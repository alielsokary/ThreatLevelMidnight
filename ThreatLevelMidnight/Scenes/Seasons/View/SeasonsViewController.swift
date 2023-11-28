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

	private let viewModel: SeasonsViewModel!
	private let disposeBag = DisposeBag()

	private let nib = "SeasonTableViewCell"

	required init?(coder: NSCoder, viewModel: SeasonsViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		configureTableView()
		setupBindings()
		selectionBindings()
	}
}

// MARK: - Setup UI

private extension SeasonsViewController {

	func setupUI() {
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
}

// MARK: - TableView Configurations

private extension SeasonsViewController {

	func configureTableView() {
		tableView.estimatedRowHeight = 250
        tableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
		tableView.dataSource = nil
		tableView.delegate = nil
		tableView.rx.setDelegate(self)
			.disposed(by: disposeBag)
	}
}

// MARK: - Setup Bindings

private extension SeasonsViewController {

	func setupBindings() {
		viewModel.seasons
			.observeOn(MainScheduler.instance)
			.bind(to: tableView.rx.items(cellIdentifier: nib, cellType: SeasonTableViewCell.self)) { _, viewModel, cell in
				cell.viewModel = viewModel
			}.disposed(by: disposeBag)

		viewModel.alertMessage
			.subscribe(onNext: { [weak self] in self?.showAlert(message: $0) })
			.disposed(by: disposeBag)

		viewModel.isLoading
			.subscribe { [weak self] isLoading in
				isLoading ? self?.showProgress() : self?.hideProgress()
			}.disposed(by: disposeBag)

		viewModel.noInternet
			.subscribe { [weak self] noInternet in
				if noInternet.element! {
					self?.showAlert(message: "No Internet Connection. Please check your connection and try again", handler: { _ in
						self?.viewModel.start()
					})
				}
			}.disposed(by: disposeBag)

		viewModel.start()
	}

	func selectionBindings() {
		tableView.rx.modelSelected(SeasonViewModel.self)
			.bind(to: viewModel.selectedSeason)
			.disposed(by: disposeBag)
	}
}

// MARK: - TableView Delegate

extension SeasonsViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
