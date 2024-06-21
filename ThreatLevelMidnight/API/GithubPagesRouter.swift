//
//  GithubPagesRouter.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 21/06/2024.
//  Copyright © 2024 mag. All rights reserved.
//

import Foundation

struct GithubPagesRouter {

    struct GetEpisodeOfTheDay: EndpointRouter {
        typealias ReturnType = EpisodeOfTheDay
        var path: String { "/\(APIConstants.episodeOfTheDay)" }
        var method: HTTPMethod = .get
    }
}
