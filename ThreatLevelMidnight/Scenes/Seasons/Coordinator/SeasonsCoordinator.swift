//
//  SeasonsCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift
import Rswift

class SeasonsCoordinator: BaseCoordinator<Void> {

	let rootViewController: UIViewController
	let service = SeasonsServiceImpl()

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {

		let viewModel = SeasonsViewModel(service: service)
		guard let viewController = R.storyboard.main.seasonsViewController() else { return Observable.empty() }

		viewController.viewModel = viewModel

		rootViewController.navigationController?.pushViewController(viewController, animated: false)

		viewModel.selectedSeason
			.flatMap({ [unowned self] (season) in
			self.coordinateToEpisodesList(with: season)
			})
			.subscribe()
			.disposed(by: disposeBag)
		return Observable.empty()
	}

	private func coordinateToEpisodesList(with viewModel: SeasonViewModel) -> Observable<Void> {
		let episodesListCoordinator = EpisodesCoordinator(rootViewController: rootViewController)
		episodesListCoordinator.seasonViewModel = viewModel
		return coordinate(to: episodesListCoordinator)
			.map { _ in () }
	}

}
