//
//  SeasonsListViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Combine

class SeasonsListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

    private let coordinator: SeasonsCoordinator!
	private let viewModel: SeasonsListViewModel!

    private var cancellables = Set<AnyCancellable>()

	private let nib = "SeasonTableViewCell"

    required init?(coder: NSCoder, coordinator: SeasonsCoordinator, viewModel: SeasonsListViewModel) {
        self.coordinator = coordinator
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
	}
}

// MARK: - Setup UI

private extension SeasonsListViewController {

	func setupUI() {
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
}

// MARK: - TableView Configurations

private extension SeasonsListViewController {

	func configureTableView() {
		tableView.estimatedRowHeight = 250
        tableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
		tableView.dataSource = self
		tableView.delegate = self
	}
}

// MARK: - Setup Bindings

private extension SeasonsListViewController {

	func setupBindings() {
		viewModel.seasons
            .sink { completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    print(error)
                }
            } receiveValue: { _ in
                self.tableView.reloadData()
            }.store(in: &cancellables)

        viewModel.$alertMessage
            .compactMap { $0 }
            .sink { message in
                self.showAlert(message: message)
            }.store(in: &cancellables)

        viewModel.$isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            }
            .store(in: &cancellables)

		viewModel.start()
	}
}

// MARK: - UITableView Datasource

extension SeasonsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.seasonsViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nib, for: indexPath) as? SeasonTableViewCell else { return UITableViewCell() }

        cell.viewModel = viewModel.seasonsViewModel[indexPath.row]
        return cell
    }
}

// MARK: - UITableView Delegate

extension SeasonsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.coordinateToEpisodesList(with: viewModel.seasonsViewModel[indexPath.row])
    }

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
