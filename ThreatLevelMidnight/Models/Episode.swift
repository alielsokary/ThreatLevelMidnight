//
//  Episode.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

// MARK: - Episode
struct Episode: Codable {
	let id: Int?
	let episodeNumber: Int?
	let seasonNumber: Int?
	let name, overview, productionCode: String?
	let airDate: String?
	let crew, guestStars: [Crew]?
	let stillPath: String?
	let voteAverage: Double?
	let voteCount: Int?

	enum CodingKeys: String, CodingKey {
		case airDate = "air_date"
		case episodeNumber = "episode_number"
		case crew
		case guestStars = "guest_stars"
		case id, name, overview
		case productionCode = "production_code"
		case seasonNumber = "season_number"
		case stillPath = "still_path"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}

	func posterUrl() -> String {
		guard let baseUrl = Configurations.currentConfig()?.images?.secureBaseURL else { return "" }
		guard let posterSize = Configurations.currentConfig()?.images?.posterSizes?.last else { return "" }
		let url = baseUrl + posterSize + (stillPath ?? "")
		return url
	}
}

// MARK: - Crew
struct Crew: Codable {
	let id: Int?
	let name, originalName: String?
	let department: String?
	let job, creditID: String?
	let adult: Bool?
	let gender: Int?
	let knownForDepartment: String?
	let popularity: Double?
	let profilePath: String?
	let character: String?
	let order: Int?

	enum CodingKeys: String, CodingKey {
		case department, job
		case creditID = "credit_id"
		case adult, gender, id
		case knownForDepartment = "known_for_department"
		case name
		case originalName = "original_name"
		case popularity
		case profilePath = "profile_path"
		case character, order
	}
}
