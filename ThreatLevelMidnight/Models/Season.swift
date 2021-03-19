//
//  Season.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

// MARK: - Season
struct Season: Codable {
	let airDate: String?
	let episodes: [Episode]?
	let episodeCount, id: Int?
	let name, overview, posterPath: String?
	let seasonNumber: Int?

	enum CodingKeys: String, CodingKey {
		case airDate = "air_date"
		case episodeCount = "episode_count"
		case id, name, overview
		case posterPath = "poster_path"
		case seasonNumber = "season_number"
		case episodes
	}

	func posterUrl() -> String {
		guard let baseUrl = Configurations.currentConfig()?.images?.secureBaseURL else { return "" }
		guard let posterSize = Configurations.currentConfig()?.images?.posterSizes?.last else { return "" }
		let url = baseUrl + posterSize + (posterPath ?? "")
		return url
	}
}

