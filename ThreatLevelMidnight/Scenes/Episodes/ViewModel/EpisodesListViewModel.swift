//
//  EpisodesViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class EpisodesListViewModel {

	private let service: TMDBService!
    private var cancellables = Set<AnyCancellable>()

    @Published var alertMessage: String?
    @Published var isLoading: Bool = false

    var episodes: PassthroughSubject = PassthroughSubject<[EpisodeViewModel], Error>()

    private var _episodesViewModel: [EpisodeViewModel] = []
    var episodesViewModel: [EpisodeViewModel] {
        return _episodesViewModel
    }

	init(service: TMDBService, season: Int?) {
		self.service = service
        isLoading = true
        service.dispatch(TMDBRouter.GetSeason(season: season!))
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.isLoading = false
        } receiveValue: { [weak self] season in
            let episodesList = season.episodes?.compactMap { EpisodeViewModel(episode: $0) }
            self?._episodesViewModel = episodesList ?? []
            self?.episodes.send(episodesList ?? [])
        }.store(in: &cancellables)
	}
}
