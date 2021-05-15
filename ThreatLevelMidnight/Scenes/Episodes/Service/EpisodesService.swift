//
//  EpisodesService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

protocol EpisodesService {
	func getSeason(season: Int) -> Observable<Season>
}

class EpisodesServiceImpl: APIClient, EpisodesService {
	func getSeason(season: Int) -> Observable<Season> {
		return request(TMDBRouter.getSeason(season: season))
	}
}
