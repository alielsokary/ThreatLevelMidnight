//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

class EpisodesCoordinator: BaseCoordinator<Void> {

	let rootViewController: UIViewController
	let service = EpisodesServiceImpl()
	var seasonViewModel: SeasonViewModel!

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {
		guard let viewController = R.storyboard.main.episodesViewController() else { return Observable.never() }

		let viewModel = EpisodesViewModel(service: service, season: seasonViewModel.number)
		viewController.viewModel = viewModel

		rootViewController.navigationController?.pushViewController(viewController, animated: true)

		return Observable.empty()
	}

}
