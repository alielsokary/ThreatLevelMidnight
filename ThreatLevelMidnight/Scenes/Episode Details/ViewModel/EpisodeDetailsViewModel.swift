//
//  EpisodeDetailsViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EpisodeDetailsViewModel {

	private let bag = DisposeBag()

	let seasonNumber = BehaviorRelay<Int>(value: 0)
	let episodeNumber = BehaviorRelay<Int>(value: 0)

	private let _episodeSubject = PublishSubject<Episode>()
	private let _alertMessage = PublishSubject<String>()

	let episode: Observable<Episode>
	let alertMessage: Observable<String>

	let service = EpisodeDetailsServiceImpl()

	init() {
		self.episode = _episodeSubject.asObserver()
		self.alertMessage = _alertMessage.asObservable()
	}

	func start() {
		service.getEpisode(season: seasonNumber.value, episode: episodeNumber.value)
			.subscribe(onNext: { [weak self] episode in
				self?._episodeSubject.onNext(episode)
			}, onError: { [weak self] error in
				self?._alertMessage.onNext(error.localizedDescription)
			}) .disposed(by: bag)

	}
}
