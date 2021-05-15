//
//  SeasonsViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SeasonsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var viewModel: SeasonsViewModel!
	private let disposeBag = DisposeBag()

	private let nib = R.nib.seasonTableViewCell

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
		viewModel.seasons
			.observeOn(MainScheduler.instance)
			.bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.seasonTableViewCell.identifier, cellType: SeasonTableViewCell.self)) { _, season, cell in
				cell.configureData(season: season)
			}.disposed(by: disposeBag)

		viewModel.start()
	}

	fileprivate func selectionBindings() {
		Observable
			.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Season.self))
			.observeOn(MainScheduler.instance)
			.bind { [weak self] _, season in
				print(season)
				let episodsVC = R.storyboard.main.episodesViewController()!
				episodsVC.viewModel.seasonId.accept(season.seasonNumber ?? 0)
				self?.navigationController?.pushViewController(episodsVC, animated: true)
			}.disposed(by: disposeBag)
	}

}

extension SeasonsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
