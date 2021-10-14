//
//  SeasonViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

struct SeasonViewModel {
	let number: Int?
	let image: String?

	init(season: Season) {
		self.number = season.seasonNumber
		self.image = season.posterUrl()
	}
}
