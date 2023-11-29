//
//  EpisodeDetailsViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Combine

class EpisodeDetailsViewController: UIViewController {

	@IBOutlet weak var episodeImageView: UIImageView!
	@IBOutlet weak var episodeNameLabel: UILabel!
	@IBOutlet weak var episodeOverView: UILabel!

	private let viewModel: EpisodeDetailsViewModel!
    private var cancellables = Set<AnyCancellable>()

	required init?(coder: NSCoder, viewModel: EpisodeDetailsViewModel) {
		self.viewModel = viewModel
		super.init(coder: coder)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupBindings()
    }

}

private extension EpisodeDetailsViewController {

	func setupBindings() {
		viewModel.episode
            .sink { completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    print(error)
                }
            } receiveValue: { episode in
                self.episodeImageView.kf.setImage(with: URL(string: episode.image ?? ""), placeholder: UIImage())
                self.episodeNameLabel.text = episode.name
                self.episodeOverView.text = episode.overview
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
