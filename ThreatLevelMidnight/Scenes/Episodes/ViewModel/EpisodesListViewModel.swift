//
//  EpisodesViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class EpisodesListViewModel: ObservableObject {

	private let service: EpisodesListService!
    private var cancellables = Set<AnyCancellable>()

    @Published var showingAlert = false
    @Published var alertMessage: String = ""

    @Published var isLoading: Bool = false

    @Published var seasonTitle: String = ""

    var episodes: PassthroughSubject = PassthroughSubject<[EpisodeViewModel], Error>()

    private var _episodesViewModel: [EpisodeViewModel] = []
    var episodesViewModel: [EpisodeViewModel] {
        return _episodesViewModel
    }

	init(service: EpisodesListService, season: Int?) {
        seasonTitle = "Season \(season!)"
		self.service = service
        isLoading = true
        showingAlert = false
        service.getSeason(season: season!)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                    self?.showingAlert = true
                }
                self?.isLoading = false
        } receiveValue: { [weak self] season in
            let episodesList = season.episodes?.compactMap { EpisodeViewModel(episode: $0) }
            self?._episodesViewModel = episodesList ?? []
            self?.episodes.send(episodesList ?? [])
        }.store(in: &cancellables)
	}
}
