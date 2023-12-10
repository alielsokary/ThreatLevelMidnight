//
//  SplashService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Combine

protocol SplashService {
    func getConfigurations() -> AnyPublisher<Configurations, NetworkRequestError>
}

class SplashServiceImpl: SplashService {
    let service = TMDBServiceImpl()
    func getConfigurations() -> AnyPublisher<Configurations, NetworkRequestError> {
        service.dispatch(TMDBRouter.GetConfiguration())
    }
}
