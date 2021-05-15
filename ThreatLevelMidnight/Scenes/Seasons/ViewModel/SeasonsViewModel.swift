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

	private let bag = DisposeBag()

	private let _tvShowSubject = PublishSubject<TVShow>()
	private let _seasonsSubject = PublishSubject<[Season]>()

	private let _alertMessage = PublishSubject<String>()

	let tvShow: Observable<TVShow>
	let seasons: Observable<[Season]>
	let alertMessage: Observable<String>

	let service: SeasonsService

	init(service: SeasonsService) {
		self.service = service

		self.tvShow = _tvShowSubject.asObserver()
		self.seasons = _seasonsSubject.asObserver()
		self.alertMessage = _alertMessage.asObservable()
	}

	func start() {
		service.getTVShow()
			.subscribe(onNext: { [weak self] tvShow in
			guard let self = self else { return }
			self._tvShowSubject.onNext(tvShow)
			self._seasonsSubject.onNext(tvShow.seasons?.filter { $0.seasonNumber != 0 } ?? [])
		}, onError: { [weak self] error in
			self?._alertMessage.onNext(error.localizedDescription)
		}).disposed(by: bag)

	}
}
