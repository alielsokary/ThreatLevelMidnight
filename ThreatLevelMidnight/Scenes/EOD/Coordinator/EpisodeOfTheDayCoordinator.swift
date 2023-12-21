//
//  EpisodeOfTheDayCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import SwiftUI

class EpisodeOfTheDayCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let service = EpisodeServiceImpl()
        let viewModel = EpisodeOfTheDayViewModel(service: service)
        let view = EpisodeOfTheDayView(coordinator: self, viewModel: viewModel)
        let hostingController = UIHostingController(rootView: view)
        let systemIcon = UIImage(systemName: "doc.plaintext.fill")
        hostingController.tabBarItem = UITabBarItem(title: viewModel.title, image: systemIcon, tag: 0)
        navigationController.pushViewController(hostingController, animated: true)
    }

    func navigateToEpisodeDetails(episodeViewModel: EpisodeViewModel) {
        let service = EpisodeServiceImpl()
        let viewModel = EpisodeDetailsViewModel(service: service, season: episodeViewModel.seasonNumber, episode: episodeViewModel.number)

        let coordinator = EpisodeDetailsCoordinator(navigationController: navigationController, viewModel: episodeViewModel)
        let view = EpisodeDetailsView(coordinator: coordinator, viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        navigationController.pushViewController(hostingController, animated: true)

    }

}
