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

	private let rootViewController: UIViewController
	private let service = SeasonsServiceImpl()

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController
	}

	override func start() -> Observable<Void> {
		let viewModel = SeasonsViewModel(service: service)
		let viewController = Storyboard.main().instantiateViewController(identifier: Storyboard.main.seasonsViewController.identifier, creator: { coder in
			return SeasonsViewController(coder: coder, viewModel: viewModel)
		})

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
		let episodesListCoordinator = EpisodesCoordinator(rootViewController: rootViewController, viewModel: viewModel)
		return coordinate(to: episodesListCoordinator)
			.map { _ in () }
	}

}
