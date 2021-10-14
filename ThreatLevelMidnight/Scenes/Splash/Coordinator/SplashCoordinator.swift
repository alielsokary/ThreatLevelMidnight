//
//  SplashCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

class SplashCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	private let service = SplashServiceImpl()

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {
		let viewController = rootViewController as? SplashViewController
		let viewModel = SplashViewModel(service: service)
		viewController?.viewModel = viewModel

		viewModel.configLoaded
			.flatMap { [unowned self] _ in
				self.coordinateToSeasonsList()
		}.subscribe()
		.disposed(by: disposeBag)

		return Observable.empty()
	}

	private func coordinateToSeasonsList() -> Observable<Void> {
		let seasonsCoordinator = SeasonsCoordinator(rootViewController: rootViewController)
		return coordinate(to: seasonsCoordinator)
			.map { _ in () }
	}
}
