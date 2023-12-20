//
//  EpisodeViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

struct EpisodeViewModel: Hashable {

	let seasonNumber: Int?
	let number: Int?
	let name: String?
	let overview: String
	let image: String?
    let episodeTitle: String
    let crew: [Crew]?
    let airDate: String?

	init(episode: Episode) {
		self.seasonNumber = episode.seasonNumber
		self.number = episode.episodeNumber
		self.name = episode.name
		self.overview = episode.overview ?? ""
		self.image = episode.posterUrl()
        self.episodeTitle = "E\(self.number ?? 0): \(self.name ?? "")"
        self.crew = episode.crew
        self.airDate = episode.airDate
	}
}
