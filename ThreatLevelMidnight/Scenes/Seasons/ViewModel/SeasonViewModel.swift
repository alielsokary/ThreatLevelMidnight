//
//  SeasonViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

struct SeasonViewModel: Hashable {

	let number: Int?
	let image: String?
    let seasonTitle: String

	init(season: Season) {
		self.number = season.seasonNumber
        self.seasonTitle = "Season \(season.seasonNumber!)"
		self.image = season.posterUrl()
	}
}
