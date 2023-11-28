//
//  EpisodesCoordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
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

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

		let viewController = storyboard.instantiateViewController(identifier: R.storyboard.main.episodesViewController.identifier) { coder in
			return EpisodesViewController(coder: coder, viewModel: viewModel)
		}

		rootViewController.navigationController?.pushViewController(viewController, animated: true)

		viewModel.selectedEpisode
			.flatMap({ [unowned self] (episode) in
				self.coordinateToEpisodeDetails(with: episode)
			}).subscribe()
			.disposed(by: disposeBag)

		return Observable.empty()
	}

	private func coordinateToEpisodeDetails(with viewModel: EpisodeViewModel) -> Observable<Void> {
		let episodeDetailsCoordinator = EpisodeDetailsCoordinator(rootViewController: rootViewController, viewModel: viewModel)
		return coordinate(to: episodeDetailsCoordinator)
			.map { _ in () }
	}

}
