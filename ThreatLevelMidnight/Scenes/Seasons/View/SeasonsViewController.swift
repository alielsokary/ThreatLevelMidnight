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

	@IBOutlet weak var seasonTableView: UITableView!

	fileprivate let viewModel = SeasonsViewModel()
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureTableView()
		setupBindings()
	}

	fileprivate func configureTableView() {
		seasonTableView.dataSource = nil
		seasonTableView.delegate = nil
		seasonTableView.register(R.nib.seasonTableViewCell)
	}

	fileprivate func setupBindings() {
		viewModel.seasons
			.observeOn(MainScheduler.instance)
			.bind(to: seasonTableView.rx.items(cellIdentifier: R.reuseIdentifier.seasonTableViewCell.identifier, cellType: SeasonTableViewCell.self)) { _, season, cell in
				cell.configureData(season: season)
			}.disposed(by: disposeBag)

		viewModel.start()
	}

}

extension SeasonsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 300
	}
}
