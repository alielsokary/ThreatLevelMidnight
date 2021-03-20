//
//  EpisodesViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EpisodesViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	private let disposeBag = DisposeBag()
	let viewModel = EpisodesViewModel()

	private let nib = R.nib.episodeTableViewCell

    override func viewDidLoad() {
        super.viewDidLoad()
		configureTableView()
		setupBindings()
		selectionBindings()
    }

	fileprivate func configureTableView() {
		tableView.estimatedRowHeight = 250
		tableView.register(nib)
		tableView.dataSource = nil
		tableView.delegate = nil
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
	}

	fileprivate func setupBindings() {
		viewModel.episodes
			.observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.episodeTableViewCell.identifier, cellType: EpisodeTableViewCell.self)) { _, episode, cell in
				cell.configureData(episode: episode)
			}.disposed(by: disposeBag)

		viewModel.start()
	}

	fileprivate func selectionBindings() {
		Observable
			.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Episode.self))
			.observeOn(MainScheduler.instance)
			.bind { [weak self] _, season in
				print(season)
				let episodsVC = R.storyboard.main.episodeDetailsViewController()!
				episodsVC.viewModel.seasonNumber.accept(season.seasonNumber ?? 0)
				episodsVC.viewModel.episodeNumber.accept(season.episodeNumber ?? 0)
				self?.navigationController?.pushViewController(episodsVC, animated: true)
			}.disposed(by: disposeBag)
	}

}

extension EpisodesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
