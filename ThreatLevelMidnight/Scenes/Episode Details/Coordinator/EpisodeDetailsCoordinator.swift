//
//  EpisodeDetailsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

class EpisodeDetailsCoordinator: BaseCoordinator<Void> {

	private let rootViewController: UIViewController
	private let episodeViewModel: EpisodeViewModel!
	private let service = EpisodeDetailsServiceImpl()

	init(rootViewController: UIViewController, viewModel: EpisodeViewModel) {
		self.rootViewController = rootViewController
		self.episodeViewModel = viewModel
	}

	override func start() -> Observable<Void> {
		let viewModel = EpisodeDetailsViewModel(service: service, season: episodeViewModel.seasonNumber, episode: episodeViewModel.number)

		let viewController = Storyboard.main().instantiateViewController(identifier: Storyboard.main.episodeDetailsViewController.identifier) { coder in
			return EpisodeDetailsViewController(coder: coder, viewModel: viewModel)
		}

		rootViewController.navigationController?.pushViewController(viewController, animated: true)
		return Observable.empty()
	}
}
