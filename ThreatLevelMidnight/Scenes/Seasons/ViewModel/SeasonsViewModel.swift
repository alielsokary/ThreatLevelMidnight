//
//  SeasonsViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SeasonsViewModel {

	private let service: SeasonsService!
	private let disposeBag = DisposeBag()

	let isLoading = BehaviorSubject<Bool>(value: false)
	let noInternet = BehaviorSubject<Bool>(value: false)
	private let _alertMessage = PublishSubject<String>()

	let seasons = BehaviorSubject<[SeasonViewModel]>(value: [])
	let selectedSeason = PublishSubject<SeasonViewModel>()
	let didClose = PublishSubject<Void>()

	let alertMessage: Observable<String>

	init(service: SeasonsService) {
		self.service = service
		self.alertMessage = _alertMessage.asObservable()
	}

	func start() {
		self.isLoading.onNext(true)
		self.noInternet.onNext(false)
		service.getTVShow()
			.subscribe(onNext: { [weak self] tvShow in
			guard let self = self else { return }
			self.isLoading.onNext(false)
				let seasonsList = tvShow.seasons?.filter { $0.seasonNumber != 0 }.compactMap {
					SeasonViewModel(season: $0)
				}
				self.seasons.onNext(seasonsList ?? [])
		}, onError: { [weak self] error in
			self?.isLoading.onNext(false)
			guard let error = error as? APIError else { return }
			switch error {
			case .noInternet:
				self?.noInternet.onNext(true)
			default:
				self?._alertMessage.onNext(error.localizedDescription)
			}
		}).disposed(by: disposeBag)

	}
}
