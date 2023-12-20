//
//  EpisodeDetailsViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class EpisodeDetailsViewModel: ObservableObject {

	private let service: EpisodeService!
    private var cancellables = Set<AnyCancellable>()

    @Published var alertMessage: String?
    @Published var isLoading: Bool = false

    @Published var episodeImage: String? = ""
    @Published var episodeTitle: String? = ""
    @Published var episodeOverView: String? = ""
    var directedByTitle: String = "Directed By"
    var writtenByTitle: String = "Written By"
    @Published var director: String = ""
    @Published var writer: String = ""
    var airDateTitle: String = "Air Date"
    @Published var airDate: String = ""

    func getDirector(episode: EpisodeViewModel) {
        director = ((episode.crew?.filter { $0.job == "Director" }.first)?.name)!
    }

    func getWriter(episode: EpisodeViewModel) {
        writer = ((episode.crew?.filter { $0.job == "Writer" }.first)?.name)!
    }

    func getAirDate(episode: EpisodeViewModel) {
        let dateString = episode.airDate!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM, dd, yyyy"
            let formattedDate = dateFormatter.string(from: date)

            airDate = formattedDate
        }
    }

	init(service: EpisodeService, season: Int?, episode: Int?) {
		self.service = service
        isLoading = true
        service.getEpisode(season: season!, episode: episode!)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.localizedDescription
                }
                self?.isLoading = false
        } receiveValue: { [weak self] episode in

            let episodeViewModel = EpisodeViewModel(episode: episode)
            self?.episodeImage = episodeViewModel.image ?? ""
            self?.episodeTitle = episodeViewModel.episodeTitle
            self?.episodeOverView = episodeViewModel.overview
            self?.getDirector(episode: episodeViewModel)
            self?.getWriter(episode: episodeViewModel)
            self?.getAirDate(episode: episodeViewModel)

        }.store(in: &cancellables)
	}
}
