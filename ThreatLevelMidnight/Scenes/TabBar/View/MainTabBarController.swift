//
//  MainTabBarController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let seasonsCoordinator = SeasonsCoordinator(navigationController: UINavigationController())
    let episodeOfTheDayCoordinator = EpisodeOfTheDayCoordinator(navigationController: UINavigationController())

}

// MARK: - Lifecycle

extension MainTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        episodeOfTheDayCoordinator.start()
        seasonsCoordinator.start()
        viewControllers = [episodeOfTheDayCoordinator.navigationController, seasonsCoordinator.navigationController]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Setup UI

private extension MainTabBarController {

    func setupUI() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
