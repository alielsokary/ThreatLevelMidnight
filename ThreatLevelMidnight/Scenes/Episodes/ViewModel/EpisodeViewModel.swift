//
//  EpisodeViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

struct EpisodeViewModel {

	let seasonNumber: Int?
	let number: Int?
	let name: String?
	let overview: String?
	let image: String?

	init(episode: Episode) {
		self.seasonNumber = episode.seasonNumber
		self.number = episode.episodeNumber
		self.name = episode.name
		self.overview = episode.overview
		self.image = episode.posterUrl()
	}

}
