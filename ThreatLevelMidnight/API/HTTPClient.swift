//
//  HTTPClient.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 29/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Foundation
import Combine

protocol HTTPClient {
    func dispatch<ReturnType: Codable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkRequestError>
}
