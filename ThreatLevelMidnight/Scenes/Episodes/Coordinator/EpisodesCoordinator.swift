//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

class EpisodesCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	private let service = EpisodesServiceImpl()
	private let seasonViewModel: SeasonViewModel!

	init(rootViewController: UIViewController, viewModel: SeasonViewModel) {
		self.rootViewController = rootViewController
		self.seasonViewModel = viewModel
	}

	override func start() -> Observable<Void> {
		let viewModel = EpisodesViewModel(service: service, season: seasonViewModel.number)

		let viewController = Storyboard.main().instantiateViewController(identifier: Storyboard.main.episodesViewController.identifier) { coder in
			return EpisodesViewController(coder: coder, viewModel: viewModel)
		}

		rootViewController.navigationController?.pushViewController(viewController, animated: true)

		return Observable.empty()
	}

}
