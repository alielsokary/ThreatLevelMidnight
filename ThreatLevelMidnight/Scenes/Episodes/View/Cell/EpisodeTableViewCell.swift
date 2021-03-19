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

	func configureData(episode: Episode) {
		episodeNumberLabel.text = "\(episode.episodeNumber ?? 0)"
		episodeNameLabel.text = episode.name
		episodeOverviewLabel.text = episode.overview
		episodeImageView.kf.setImage(with: URL(string: episode.posterUrl()), placeholder: UIImage())
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
