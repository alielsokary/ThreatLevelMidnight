//
//  EpisodesViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EpisodesViewModel {

	private let bag = DisposeBag()

	let seasonId = BehaviorRelay<Int>(value: 0)

	let service = EpisodesServiceImpl()

	private let _episodesSubject = PublishSubject<[Episode]>()
	private let _alertMessage = PublishSubject<String>()

	let episodes: Observable<[Episode]>
	let alertMessage: Observable<String>

	init() {
		self.episodes = _episodesSubject.asObserver()
		self.alertMessage = _alertMessage.asObservable()
	}

	func start() {
		service.getSeason(season: seasonId.value)
			.subscribe(onNext: { [weak self] season in
				guard let self = self else { return }
				self._episodesSubject.onNext(season.episodes ?? [])
		}, onError: { [weak self] error in
			guard let self = self else { return }
			self._alertMessage.onNext(error.localizedDescription)
		}).disposed(by: bag)
	}
}
