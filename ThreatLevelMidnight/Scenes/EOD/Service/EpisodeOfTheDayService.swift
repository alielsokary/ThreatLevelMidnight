//
//  EpisodeOfTheDayService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 21/06/2024.
//  Copyright © 2024 mag. All rights reserved.
//

import Combine

protocol EpisodeOfTheDayService {
    func getEpisodeOfTheDay() -> AnyPublisher<EpisodeOfTheDay, NetworkRequestError>
}

class EpisodeOfTheDayServiceImpl: EpisodeOfTheDayService {
    let service = GithubPageserviceImpl()
    func getEpisodeOfTheDay() -> AnyPublisher<EpisodeOfTheDay, NetworkRequestError> {
        service.dispatch(GithubPagesRouter.GetEpisodeOfTheDay())
    }
}
