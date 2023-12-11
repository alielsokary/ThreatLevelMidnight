//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import SwiftUI

class EpisodesCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	private let service = EpisodesListServiceImpl()
	private let seasonViewModel: SeasonViewModel!

	init(navigationController: UINavigationController, viewModel: SeasonViewModel) {
		self.navigationController = navigationController
		self.seasonViewModel = viewModel
	}

    func start() {
		let viewModel = EpisodesListViewModel(service: service, season: seasonViewModel.number)

        let view = EpisodesListView(coordinator: self, viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)
	}

    func coordinateToEpisodeDetails(with viewModel: EpisodeViewModel) {
		let coordinator = EpisodeDetailsCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.start()
	}

}
