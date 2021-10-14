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

	// MARK: - Properties
	var viewModel: SeasonViewModel! {
		didSet {
			self.configure()
		}
	}
}

extension SeasonTableViewCell {
	func configure() {
		seasonLabel.text = "\(viewModel.number ?? 0)"
		seasonImageView.kf.setImage(with: URL(string: viewModel.image ?? ""), placeholder: UIImage())
	}
}
