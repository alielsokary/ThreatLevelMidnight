//
//  EpisodeService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import Combine

protocol EpisodeService {
    func getEpisode(season: Int, episode: Int) -> AnyPublisher<Episode, NetworkRequestError>
}

class EpisodeServiceImpl: EpisodeService {
    let service = TMDBServiceImpl()
    func getEpisode(season: Int, episode: Int) -> AnyPublisher<Episode, NetworkRequestError> {
        service.dispatch(TMDBRouter.GetEpisode(season: season, episode: episode))
    }
}
