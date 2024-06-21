//
//  GithubPagesService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 21/06/2024.
//  Copyright © 2024 mag. All rights reserved.
//

import Foundation
import Combine

protocol GithubPageservice {
    func dispatch<R: EndpointRouter>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
}

struct GithubPageserviceImpl: GithubPageservice {

    private let apiClient: APIClient = APIClient()

    init() {}

    @discardableResult
    func dispatch<R: EndpointRouter>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: APIConstants.githubPagesURL) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = apiClient.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
