//
//  TMDBRouter.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Alamofire

enum TMDBRouter: URLRequestBuilder {

	case getConfiguration
	case getShow
	case getSeason(season: Int)
	case getEpisode(season: Int, episode: Int)

	// MARK: - Path
	var path: String {
		switch self {
		case .getConfiguration:
			return "/\(APIConstants.configuration)"
		case .getShow:
			return "/\(APIConstants.type)/\(APIConstants.theOfficeId)"
		case .getSeason(let season):
			return "/\(APIConstants.type)/\(APIConstants.theOfficeId)/\(APIConstants.season)/\(season)"
		case .getEpisode(let season, let episode):
			return "/\(APIConstants.type)/\(APIConstants.theOfficeId)/\(APIConstants.season)/\(season)/\(APIConstants.episode)/\(episode)"
		}
	}

	// MARK: - Parameters
	var parameters: Parameters? {
		let params = defaultParams
		switch self {
		default:
			return params
		}
	}

	// MARK: - Methods
	var method: HTTPMethod {
		return .get
	}
}
