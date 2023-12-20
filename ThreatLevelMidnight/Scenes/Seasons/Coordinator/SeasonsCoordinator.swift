//
//  SeasonsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import SwiftUI

class SeasonsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

	private let service = SeasonListServiceImpl()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
		let viewModel = SeasonsListViewModel(service: service)
        let view = SeasonsListView(coordinator: self, viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        let systemIcon = UIImage(systemName: "list.bullet.rectangle")
        hostingController.tabBarItem = UITabBarItem(title: viewModel.title, image: systemIcon, tag: 1)
        navigationController.pushViewController(hostingController, animated: true)
	}

    func coordinateToEpisodesList(with viewModel: SeasonViewModel) {
		let coordinator = EpisodesCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinator.start()
	}

}
