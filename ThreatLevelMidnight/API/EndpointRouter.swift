//
//  EndpointRouter.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

protocol EndpointRouter {
    var path: String { get }

    var method: HTTPMethod { get }

    var contentType: String { get }

    var body: [String: Any]? { get }

    var queryParams: [String: Any]? { get }

    var headers: [String: String]? { get }

    associatedtype ReturnType: Codable
}

extension EndpointRouter {

    var method: HTTPMethod { return .get }

    var contentType: String { return "application/json" }

    var queryParams: [String: Any]? { return nil }

    var body: [String: Any]? { return nil }

    var headers: [String: String]? {
        var httpHeaders = [String: String]()
        httpHeaders[APIConstants.HTTPHeaderKeyField.authorization.rawValue] = "Bearer \(APIConstants.accessToken)"
        httpHeaders[APIConstants.HTTPHeaderKeyField.contentType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
        httpHeaders[APIConstants.HTTPHeaderKeyField.acceptType.rawValue] = APIConstants.HTTPHeaderValueField.applicationJson.rawValue
        return httpHeaders
    }

    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }

    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers

        request.setValue(APIConstants.HTTPHeaderValueField.applicationJson.rawValue, forHTTPHeaderField: APIConstants.HTTPHeaderKeyField.acceptType.rawValue)

        return request
    }
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}
