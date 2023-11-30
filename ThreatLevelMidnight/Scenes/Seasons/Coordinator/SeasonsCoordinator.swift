//
//  SeasonsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class SeasonsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

	private let service = SeasonListServiceImpl()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
		let viewModel = SeasonsListViewModel(service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(identifier: "SeasonsListViewController", creator: { coder in
            return SeasonsListViewController(coder: coder, coordinator: self, viewModel: viewModel)
		})
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        navigationController.pushViewController(viewController, animated: false)
	}

    func coordinateToEpisodesList(with viewModel: SeasonViewModel) {
		let coordinator = EpisodesCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.start()
	}

}
