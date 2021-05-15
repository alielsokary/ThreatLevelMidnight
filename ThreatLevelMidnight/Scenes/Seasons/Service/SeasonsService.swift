//
//  SeasonsService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

protocol SeasonsService {
	func getTVShow() -> Observable<TVShow>
}

class SeasonsServiceImpl: APIClient, SeasonsService {
	func getTVShow() -> Observable<TVShow> {
		return request(TMDBRouter.getShow)
	}
}
