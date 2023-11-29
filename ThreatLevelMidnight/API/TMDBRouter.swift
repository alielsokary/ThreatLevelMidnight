//
//  TMDBRouter.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 19/02/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

struct TMDBRouter {

    struct GetConfiguration: EndpointRouter {
        typealias ReturnType = Configurations
        var path: String { "/\(APIConstants.configuration)" }
        var method: HTTPMethod = .get
    }

    struct GetShow: EndpointRouter {
        typealias ReturnType = TVShow

        var path: String { "/\(APIConstants.type)/\(APIConstants.theOfficeId)" }
        var method: HTTPMethod = .get
    }

    struct GetSeason: EndpointRouter {
        typealias ReturnType = Season
        let season: Int

        var path: String { "/\(APIConstants.type)/\(APIConstants.theOfficeId)/\(APIConstants.season)/\(season)" }

        var method: HTTPMethod = .get
    }

    struct GetEpisode: EndpointRouter {
        typealias ReturnType = Episode
        let season: Int
        let episode: Int

        var path: String { "/\(APIConstants.type)/\(APIConstants.theOfficeId)/\(APIConstants.season)/\(season)/\(APIConstants.episode)/\(episode)" }
        var method: HTTPMethod = .get
    }
}
