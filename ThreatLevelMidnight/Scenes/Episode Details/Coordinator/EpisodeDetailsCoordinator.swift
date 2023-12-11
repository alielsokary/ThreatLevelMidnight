//
//  EpisodeDetailsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import SwiftUI

class EpisodeDetailsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
	private let episodeViewModel: EpisodeViewModel!
	private let service = EpisodeServiceImpl()

	init(navigationController: UINavigationController, viewModel: EpisodeViewModel) {
		self.navigationController = navigationController
		self.episodeViewModel = viewModel
	}

    func start() {
		let viewModel = EpisodeDetailsViewModel(service: service, season: episodeViewModel.seasonNumber, episode: episodeViewModel.number)

        let view = EpisodeDetailsView(coordinator: self, viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)

	}
}
