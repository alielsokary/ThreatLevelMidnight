//
//  TMDBRouter.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Alamofire

enum TMDBRouter: URLRequestConvertible {

	case getConfiguration
	case getShow
	case getSeason(season: Int)
	case getEpisode(season: Int, episode: Int)

	// MARK: - HTTPMethod
	private var method: HTTPMethod {
		switch self {
		case .getConfiguration:
			return .get
		case .getShow:
			return .get
		case .getSeason:
			return .get
		case .getEpisode:
			return .get
		}
	}

	// MARK: - Path
	private var path: String {
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
	private var parameters: Parameters? {
		switch self {
		default:
			return nil
		}
	}

	private var body: Parameters? {
		switch self {
		default:
			return nil
		}
	}

	// MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		let url = try APIConstants.tmdbURL.asURL()
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue

		urlRequest.setValue(APIConstants.HTTPHeaderValueField.applicationJson.rawValue, forHTTPHeaderField: APIConstants.HTTPHeaderKeyField.acceptType.rawValue)
		urlRequest.setValue(APIConstants.HTTPHeaderValueField.applicationJson.rawValue, forHTTPHeaderField: APIConstants.HTTPHeaderKeyField.contentType.rawValue)
		urlRequest.setValue("Bearer \(APIConstants.accessToken)", forHTTPHeaderField: APIConstants.HTTPHeaderKeyField.authorization.rawValue)

		// Add http body to request
		if let body = body {
			do {
				let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
				urlRequest.httpBody = data
			} catch {
				throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
			}
		}

		// Add query parameters to request
		if let parameters = parameters {
			urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
		}

		return urlRequest
	}
}
