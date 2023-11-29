//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class EpisodesCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
	var navigationController: UINavigationController
	private let service = EpisodesServiceImpl()
	private let seasonViewModel: SeasonViewModel!

	init(navigationController: UINavigationController, viewModel: SeasonViewModel) {
		self.navigationController = navigationController
		self.seasonViewModel = viewModel
	}

    func start() {
		let viewModel = EpisodesViewModel(service: service, season: seasonViewModel.number)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

		let viewController = storyboard.instantiateViewController(identifier: "EpisodesViewController") { coder in
			return EpisodesViewController(coder: coder, viewModel: viewModel)
		}

		navigationController.pushViewController(viewController, animated: true)

//		viewModel.selectedEpisode
//			.flatMap({ [unowned self] (episode) in
//				self.coordinateToEpisodeDetails(with: episode)
//			}).subscribe()
//			.disposed(by: disposeBag)

	}

//	private func coordinateToEpisodeDetails(with viewModel: EpisodeViewModel) -> Observable<Void> {
//		let episodeDetailsCoordinator = EpisodeDetailsCoordinator(rootViewController: rootViewController, viewModel: viewModel)
//		return coordinate(to: episodeDetailsCoordinator)
//			.map { _ in () }
//	}

}
