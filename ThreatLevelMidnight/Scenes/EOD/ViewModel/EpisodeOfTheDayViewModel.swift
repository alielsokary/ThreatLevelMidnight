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

        let today = Date()
        let todayEpisode = generateEpisode(for: today)
        self.getEpisodeDetails(season: todayEpisode.season, episode: todayEpisode.episode)
    }

    func generateEpisode(for date: Date) -> (season: Int, episode: Int) {
        let seasons = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let episodes = [
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23]
        ]

        // Convert the date to a string in the format "YYYYMMDD" to create a seed
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)

        // Convert the date string to an integer seed
        guard let seed = Int(dateString) else {
            fatalError("Invalid date format")
        }

        // Seed the random generator
        var generator = SeededGenerator(seed: seed)

        // Generate random season and episode
        let season = seasons.randomElement(using: &generator)!
        let episode = episodes[season - 1].randomElement(using: &generator)!

        return (season, episode)
    }

    struct SeededGenerator: RandomNumberGenerator {
        private var state: UInt64

        init(seed: Int) {
            self.state = UInt64(seed)
        }

        mutating func next() -> UInt64 {
            state = state &* 6364136223846793005 &+ 1
            return state
        }
    }

    func getEpisodeDetails(season: Int, episode: Int) {
        self.isLoading = true
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
