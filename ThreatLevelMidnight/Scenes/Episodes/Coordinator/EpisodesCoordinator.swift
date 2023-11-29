//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class EpisodesCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	private let service = TMDBServiceImpl()
	private let seasonViewModel: SeasonViewModel!

	init(navigationController: UINavigationController, viewModel: SeasonViewModel) {
		self.navigationController = navigationController
		self.seasonViewModel = viewModel
	}

    func start() {
		let viewModel = EpisodesListViewModel(service: service, season: seasonViewModel.number)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

		let viewController = storyboard.instantiateViewController(identifier: "EpisodesViewController") { coder in
            return EpisodesListViewController(coder: coder, coordinator: self, viewModel: viewModel)
		}

		navigationController.pushViewController(viewController, animated: true)
	}

    func coordinateToEpisodeDetails(with viewModel: EpisodeViewModel) {
		let coordinator = EpisodeDetailsCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.start()
	}

}
