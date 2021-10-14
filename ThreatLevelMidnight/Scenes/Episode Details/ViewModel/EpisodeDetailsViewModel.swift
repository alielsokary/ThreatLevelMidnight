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

	private let service: EpisodeDetailsService!
	private let disposeBag = DisposeBag()

	private let _episodeSubject = PublishSubject<Episode>()
	private let _alertMessage = PublishSubject<String>()

	let episode: Observable<Episode>
	let alertMessage: Observable<String>

	init(service: EpisodeDetailsService, season: Int?, episode: Int?) {
		self.service = service
		self.episode = _episodeSubject.asObserver()
		self.alertMessage = _alertMessage.asObservable()

		service.getEpisode(season: season!, episode: episode!)
			.subscribe(onNext: { [weak self] episode in
				self?._episodeSubject.onNext(episode)
			}, onError: { [weak self] error in
				self?._alertMessage.onNext(error.localizedDescription)
			}) .disposed(by: disposeBag)
	}
}
