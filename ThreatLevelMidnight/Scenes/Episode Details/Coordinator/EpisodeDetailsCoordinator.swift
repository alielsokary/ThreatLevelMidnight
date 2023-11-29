//
//  EpisodeDetailsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class EpisodeDetailsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
	private let episodeViewModel: EpisodeViewModel!
	private let service = TMDBServiceImpl()

	init(navigationController: UINavigationController, viewModel: EpisodeViewModel) {
		self.navigationController = navigationController
		self.episodeViewModel = viewModel
	}

    func start() {
		let viewModel = EpisodeDetailsViewModel(service: service, season: episodeViewModel.seasonNumber, episode: episodeViewModel.number)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "EpisodeDetailsViewController") { coder in
			return EpisodeDetailsViewController(coder: coder, viewModel: viewModel)
		}

        navigationController.pushViewController(viewController, animated: true)
	}
}
