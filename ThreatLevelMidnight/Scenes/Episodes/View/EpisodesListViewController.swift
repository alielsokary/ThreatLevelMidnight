//
//  EpisodesListViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Combine

class EpisodesListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	private let viewModel: EpisodesListViewModel!
    private let coordinator: EpisodesCoordinator!
    private var cancellables = Set<AnyCancellable>()

	private let nib = "EpisodeTableViewCell"

    required init?(coder: NSCoder, coordinator: EpisodesCoordinator, viewModel: EpisodesListViewModel) {
        self.coordinator = coordinator
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
    }
}

// MARK: - TableView Configurations

private extension EpisodesListViewController {
	func configureTableView() {
		tableView.estimatedRowHeight = 250
		tableView.register(UINib(nibName: nib, bundle: nil), forCellReuseIdentifier: nib)
		tableView.dataSource = self
		tableView.delegate = self
	}
}

// MARK: - Setup Bindings

private extension EpisodesListViewController {
	func setupBindings() {
        viewModel.episodes
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

	}
}

// MARK: - UITableviewDataSource

extension EpisodesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.episodesViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nib, for: indexPath) as? EpisodeTableViewCell else { return UITableViewCell() }

        cell.viewModel = viewModel.episodesViewModel[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EpisodesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.coordinateToEpisodeDetails(with: viewModel.episodesViewModel[indexPath.row])
    }

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}
