//
//  EpisodeOfTheDayCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import UIKit

class EpisodeOfTheDayCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    private let service = TMDBServiceImpl()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = EpisodeOfTheDayViewModel()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "EpisodeOfTheDayViewController", creator: { coder in
            return EpisodeOfTheDayViewController(coder: coder, coordinator: self, viewModel: viewModel)
        })
        let systemIcon = UIImage(systemName: "doc.plaintext.fill")
        viewController.tabBarItem = UITabBarItem(title: viewModel.title, image: systemIcon, tag: 0)
        navigationController.pushViewController(viewController, animated: false)
    }

}
