//
//  APIConstants.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Keys

struct APIConstants {

	static let accessToken = ThreatLevelMidnightKeys().tMDBAccessToken
	static let configuration = "configuration"
	static let version = "3"
	static let type = "tv"
	static let theOfficeId = "2316"
	static let season = "season"
	static let episode = "episode"
	static let tmdbURL = "https://api.themoviedb.org/\(version)"

	enum ParameterKey: String {
		case id
		case language
	}

	enum ParameterValue: String {
		case languageValue = "en-US"
	}

	enum HTTPHeaderKeyField: String {
		case contentType = "Content-Type"
		case acceptType = "Accept"
		case authorization = "Authorization"
	}

	enum HTTPHeaderValueField: String {
		case applicationJson = "application/json"
	}

}
