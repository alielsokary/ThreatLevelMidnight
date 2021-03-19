//
//  SeasonTableViewCell.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Kingfisher

class SeasonTableViewCell: UITableViewCell {

	@IBOutlet weak var seasonImageView: UIImageView!
	@IBOutlet weak var seasonLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

	func configureData(season: Season) {
		seasonImageView.kf.setImage(with: URL(string: season.posterUrl()), placeholder: UIImage())
		seasonLabel.text = "\(season.seasonNumber ?? 0)"
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
