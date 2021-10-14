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

	private let service: EpisodesService!
	private let disposeBag = DisposeBag()

	// MARK: - Actions
	let selectedEpisode = PublishSubject<EpisodeViewModel>()

	private let _alertMessage = PublishSubject<String>()

	let episodes = BehaviorSubject<[EpisodeViewModel]>(value: [])
	let alertMessage: Observable<String>

	init(service: EpisodesService, season: Int?) {
		self.service = service
		self.alertMessage = _alertMessage.asObservable()

		self.service.getSeason(season: season!)
			.subscribe(onNext: { [weak self] season in
				guard let self = self else { return }
				let episodesList = season.episodes?.compactMap { EpisodeViewModel(episode: $0) }
				self.episodes.onNext(episodesList ?? [])
		}, onError: { [weak self] error in
			guard let self = self else { return }
			self._alertMessage.onNext(error.localizedDescription)
		}).disposed(by: disposeBag)
	}
}
