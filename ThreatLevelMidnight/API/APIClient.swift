//
//  APIClient.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

public struct APIClient: HTTPClient {

    private let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Dispatches an URLRequest and returns a publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError> {
        print("[\(request.httpMethod?.uppercased() ?? "")] '\(request.url!)'")
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ data, response in

                guard let response = response as? HTTPURLResponse else {
                    throw httpError(0)
                }

                print("[\(response.statusCode)] '\(request.url!)'")

                if !(200...299).contains(response.statusCode) {
                    throw httpError(response.statusCode)
                }

                return data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { error in
                return handleError(error)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Error Handling

public enum NetworkRequestError: LocalizedError, Equatable {
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError( _ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case unknownError
}

extension APIClient {
    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }

    /// Parses URLSession Publisher errors and return proper ones
    /// - Parameter error: URLSession publisher error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> NetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
