//
//  SeasonsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit

class SeasonsCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

	private let service = SeasonsServiceImpl()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
		let viewModel = SeasonsViewModel(service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let viewController = storyboard.instantiateViewController(identifier: "SeasonsViewController", creator: { coder in
			return SeasonsViewController(coder: coder, viewModel: viewModel)
		})

        navigationController.pushViewController(viewController, animated: false)

//		viewModel.selectedSeason
//			.flatMap({ [unowned self] (season) in
//			self.coordinateToEpisodesList(with: season)
//			})
//			.subscribe()
//			.disposed(by: disposeBag)
//		return Observable.empty()
	}

//	private func coordinateToEpisodesList(with viewModel: SeasonViewModel) -> Observable<Void> {
//		let episodesListCoordinator = EpisodesCoordinator(rootViewController: rootViewController, viewModel: viewModel)
//		return coordinate(to: episodesListCoordinator)
//			.map { _ in () }
//	}

}
