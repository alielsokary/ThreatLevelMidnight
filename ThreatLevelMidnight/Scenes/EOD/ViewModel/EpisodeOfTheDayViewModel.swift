//
//  EpisodeOfTheDayViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Foundation
import Combine

class EpisodeOfTheDayViewModel: ObservableObject {

    var title: String { "EOD" }
    private let service: EpisodeService!
    private var cancellables = Set<AnyCancellable>()

    @Published var alertMessage: String?
    @Published var isLoading: Bool = false

    @Published var episodeImage: String = ""
    @Published var episodeTitle: String = ""

    var episodeViewModel: EpisodeViewModel!

    func getEpisodeDetails(episode: EpisodeViewModel) {
        episodeTitle = episode.name!
        episodeImage = episode.image!
    }

    init(service: EpisodeService) {
        let episodeOfTheDayService = EpisodeOfTheDayServiceImpl()
        self.service = service
        isLoading = true
        episodeOfTheDayService.getEpisodeOfTheDay()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.isLoading = false
        } receiveValue: { [weak self] ep in
            self?.getEpisodeDetails(season: ep.season, episode: ep.episode)

        }.store(in: &cancellables)
    }

    func getEpisodeDetails(season: Int, episode: Int) {
        service.getEpisode(season: season, episode: episode)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.isLoading = false
        } receiveValue: { [weak self] ep in
            let episodeViewModel = EpisodeViewModel(episode: ep)
            self?.episodeViewModel = episodeViewModel
            self?.getEpisodeDetails(episode: episodeViewModel)

        }.store(in: &cancellables)
    }
}
