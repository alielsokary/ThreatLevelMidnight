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
        self.service = service
        isLoading = true
        let (season, episode) = getEpisodeDetails()
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

protocol EpisodeOfTheDayLogic {
    var seasons: [Int] { get }
    var episodes: [[Int]] { get }

    func getEpisodeDetails() -> (Int, Int)
}

extension EpisodeOfTheDayViewModel: EpisodeOfTheDayLogic {
    var seasons: [Int] {
        [1, 2, 3, 4, 5, 6, 7, 8, 9]
    }

    var episodes: [[Int]] {
        [[1, 2, 3, 4, 5, 6],
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
                                 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]]
    }

    func getEpisodeDetails() -> (Int, Int) {
        let season = seasons.randomElement()!
        let episode = episodes[season-1].randomElement()!

        return (season, episode)
    }
}
