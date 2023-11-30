//
//  EpisodesListService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Combine

protocol EpisodesListService {
    func getSeason(season: Int) -> AnyPublisher<Season, NetworkRequestError>
}

class EpisodesListServiceImpl: EpisodesListService {
    let service = TMDBServiceImpl()
    func getSeason(season: Int) -> AnyPublisher<Season, NetworkRequestError> {
        service.dispatch(TMDBRouter.GetSeason(season: season))
    }
}
