//
//  EpisodeTableViewCell.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Kingfisher

class EpisodeTableViewCell: UITableViewCell {

	@IBOutlet weak var episodeImageView: UIImageView!
	@IBOutlet weak var episodeNumberLabel: UILabel!
	@IBOutlet weak var episodeNameLabel: UILabel!
	@IBOutlet weak var episodeOverviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

	// MARK: - Properties
	var viewModel: EpisodeViewModel! {
		didSet {
			self.configure()
		}
	}

}

extension EpisodeTableViewCell {

	func configure() {
		episodeNumberLabel.text = "\(viewModel.number ?? 0)"
		episodeNameLabel.text = viewModel.name
		episodeOverviewLabel.text = viewModel.overview
		episodeImageView.kf.setImage(with: URL(string: viewModel.image ?? ""), placeholder: UIImage())
	}
}
