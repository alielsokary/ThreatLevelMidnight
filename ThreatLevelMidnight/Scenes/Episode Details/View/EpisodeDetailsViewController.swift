//
//  EpisodeDetailsViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EpisodeDetailsViewController: UIViewController {

	@IBOutlet weak var episodeImageView: UIImageView!
	@IBOutlet weak var episodeNameLabel: UILabel!
	@IBOutlet weak var episodeOverView: UILabel!

	private let viewModel: EpisodeDetailsViewModel!
	private let disposeBag = DisposeBag()

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
			.observeOn(MainScheduler.instance)
			.subscribe({ [weak self] episode in
				guard let self = self else { return }
				self.episodeImageView.kf.setImage(with: URL(string: episode.element?.posterUrl() ?? ""), placeholder: UIImage())
				self.episodeNameLabel.text = episode.element?.name
				self.episodeOverView.text = episode.element?.overview
			}).disposed(by: disposeBag)
	}
}
