//
//  SplashCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class SplashCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

	private let service = TMDBServiceImpl()

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else { return }
		let viewModel = SplashViewModel(service: service)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)

        _ = viewModel.$configLoaded
            .subscribe(on: DispatchQueue.global(qos: .default))
            .sink { [weak self] value in
                if value {
                    self?.coordinateToMainTabBar()
                }
        }
	}

	private func coordinateToMainTabBar() {
		let coordinator = TabBarCoordinator(navigationController: navigationController)
        coordinator.start()
	}
}
