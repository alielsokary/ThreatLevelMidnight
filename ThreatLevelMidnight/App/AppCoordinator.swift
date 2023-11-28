//
//  AppCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	override func start() -> Observable<Void> {
		guard let viewcontroller = R.storyboard.main.splashViewController() else { return  Observable.empty() }
		let navigationController = UINavigationController(rootViewController: viewcontroller)

		let splashCoordinator = SplashCoordinator(rootViewController: navigationController.viewControllers[0])

		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		return coordinate(to: splashCoordinator)
	}
}
