//
//  SeasonsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

class SeasonsCoordinator: BaseCoordinator<Void> {

	let rootViewController: UIViewController

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	let service = SeasonsServiceImpl()

	override func start() -> Observable<Void> {
		guard let viewController = R.storyboard.main.seasonsViewController() else { return Observable.never() }

		let navigationController = UINavigationController(rootViewController: viewController)

		let viewModel = SeasonsViewModel(service: service)
		viewController.viewModel = viewModel
		navigationController.modalPresentationStyle = .fullScreen
		rootViewController.navigationController?.present(navigationController, animated: false)
		return Observable.never()
	}

}
