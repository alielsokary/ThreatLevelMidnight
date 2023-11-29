//
//  SeasonsListViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class SeasonsListViewModel: ObservableObject {

	private let service: TMDBService!

    var seasons: PassthroughSubject = PassthroughSubject<[SeasonViewModel], Error>()

    @Published var isLoading: Bool = false
    @Published var alertMessage: String?

    private var cancellables = Set<AnyCancellable>()

	init(service: TMDBService) {
		self.service = service
	}

    private var _seasonsViewModel: [SeasonViewModel] = []
    var seasonsViewModel: [SeasonViewModel] {
        return _seasonsViewModel
    }

	func start() {
        isLoading = true
        service.dispatch(TMDBRouter.GetShow())
            .sink { [weak self] completions in
            switch completions {
            case .finished:
                break

            case let .failure(error):
                self?.alertMessage = error.localizedDescription
            }
            self?.isLoading = false
        } receiveValue: { [weak self] tvShow in
            let seasonsList = tvShow.seasons?.filter { $0.seasonNumber != 0 }.compactMap {
                SeasonViewModel(season: $0)
            }
            self?._seasonsViewModel = seasonsList ?? []
            self?.seasons.send(seasonsList ?? [])
        }.store(in: &cancellables)
	}
}
