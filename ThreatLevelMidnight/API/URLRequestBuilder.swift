//
//  URLRequestBuilder.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
	var mainURL: URL { get }
	var requestURL: URL { get }

	var path: String { get }

	var headers: HTTPHeaders { get }

	var parameters: Parameters? { get }

	var method: HTTPMethod { get }

	var encoding: ParameterEncoding { get }

	var urlRequest: URLRequest { get }
}

extension URLRequestBuilder {
	var mainURL: URL {
		#if DEBUG
		return URL(string: "\(APIConstants.tmdbURL)")!
		#else
		return URL(string: "\(APIConstants.tmdbURL)")!
		#endif
	}

	var requestURL: URL {
		return mainURL.appendingPathComponent(path)
	}

	var headers: HTTPHeaders {
		var headers = HTTPHeaders()
		headers[APIConstants.HTTPHeaderKeyField.authorization.rawValue] = "Bearer \(APIConstants.accessToken)"
		headers[APIConstants.HTTPHeaderKeyField.contentType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
		headers[APIConstants.HTTPHeaderKeyField.acceptType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
		return headers
	}

	var defaultParams: Parameters {
		let params = Parameters()
		return params
	}

	var encoding: ParameterEncoding {
		switch method {
		case .get:
			return URLEncoding.default

		default:
			return JSONEncoding.default
		}
	}

	var urlRequest: URLRequest {
		var request = URLRequest(url: requestURL)
		request.httpMethod = method.rawValue
		headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name)}
		return request
	}

	func asURLRequest() throws -> URLRequest {
		return try encoding.encode(urlRequest, with: parameters)
	}
}
