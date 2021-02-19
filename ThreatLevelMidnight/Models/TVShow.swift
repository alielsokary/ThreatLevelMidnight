//
//  TVShow.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
	let backdropPath: String?
	let createdBy: [CreatedBy]?
	let episodeRunTime: [Int]?
	let firstAirDate: String?
	let homepage: String?
	let id: Int?
	let inProduction: Bool?
	let languages: [String]?
	let lastAirDate: String?
	let name: String?
	let numberOfEpisodes, numberOfSeasons: Int?
	let originCountry: [String]?
	let originalLanguage, originalName, overview: String?
	let popularity: Double?
	let posterPath: String?
	let seasons: [Season]?
	let status, tagline, type: String?
	let voteAverage: Double?
	let voteCount: Int?

	enum CodingKeys: String, CodingKey {
		case backdropPath = "backdrop_path"
		case createdBy = "created_by"
		case episodeRunTime = "episode_run_time"
		case firstAirDate = "first_air_date"
		case homepage, id
		case inProduction = "in_production"
		case languages
		case lastAirDate = "last_air_date"
		case name
		case numberOfEpisodes = "number_of_episodes"
		case numberOfSeasons = "number_of_seasons"
		case originCountry = "origin_country"
		case originalLanguage = "original_language"
		case originalName = "original_name"
		case overview, popularity
		case posterPath = "poster_path"
		case seasons
		case status, tagline, type
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
	let id: Int?
	let creditID, name: String?
	let gender: Int?
	let profilePath: String?

	enum CodingKeys: String, CodingKey {
		case id
		case creditID = "credit_id"
		case name, gender
		case profilePath = "profile_path"
	}
}

// MARK: - Season
struct Season: Codable {
	let airDate: String?
	let episodeCount, id: Int?
	let name, overview, posterPath: String?
	let seasonNumber: Int?

	enum CodingKeys: String, CodingKey {
		case airDate = "air_date"
		case episodeCount = "episode_count"
		case id, name, overview
		case posterPath = "poster_path"
		case seasonNumber = "season_number"
	}
}
