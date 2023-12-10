//
//  EpisodeDetailsViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class EpisodeDetailsViewModel {

	private let service: EpisodeService!
    private var cancellables = Set<AnyCancellable>()

    @Published var alertMessage: String?
    @Published var isLoading: Bool = false

    var episode: PassthroughSubject = PassthroughSubject<EpisodeViewModel, Error>()

	init(service: EpisodeService, season: Int?, episode: Int?) {
		self.service = service
        isLoading = true
        service.getSeason(season: season!, episode: episode!)
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
            self?.episode.send(episodeViewModel)

        }.store(in: &cancellables)
	}
}
