//
//  SeasonsListService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Combine

protocol SeasonListService {
    func getShow() -> AnyPublisher<TVShow, NetworkRequestError>
}

class SeasonListServiceImpl: SeasonListService {
    let service = TMDBServiceImpl()
    func getShow() -> AnyPublisher<TVShow, NetworkRequestError> {
        service.dispatch(TMDBRouter.GetShow())
    }
}
