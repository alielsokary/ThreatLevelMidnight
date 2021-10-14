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

	private var viewModel: EpisodesViewModel!
	private let disposeBag = DisposeBag()

	private let nib = R.nib.episodeTableViewCell

	required init?(coder: NSCoder, viewModel: EpisodesViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		configureTableView()
		setupBindings()
		selectionBindings()
    }
}

// MARK: - TableView Configurations

private extension EpisodesViewController {
	func configureTableView() {
		tableView.estimatedRowHeight = 250
		tableView.register(nib)
		tableView.dataSource = nil
		tableView.delegate = nil
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
	}
}

// MARK: - Setup Bindings
private extension EpisodesViewController {
	func setupBindings() {
		viewModel.episodes
			.observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.episodeTableViewCell.identifier, cellType: EpisodeTableViewCell.self)) { _, episode, cell in
				cell.configureData(episode: episode)
			}.disposed(by: disposeBag)
	}

	func selectionBindings() {
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

// MARK: - TableView Delegate

extension EpisodesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
