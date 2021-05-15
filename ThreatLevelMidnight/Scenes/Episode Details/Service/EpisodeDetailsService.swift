//
//  EpisodeDetailsService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

protocol EpisodeDetailsService {
	func getEpisode(season: Int, episode: Int) -> Observable<Episode>
}

class EpisodeDetailsServiceImpl: APIClient, EpisodeDetailsService {
	func getEpisode(season: Int, episode: Int) -> Observable<Episode> {
		return request(TMDBRouter.getEpisode(season: season, episode: episode))
	}
}
