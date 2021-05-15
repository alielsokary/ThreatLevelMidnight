//
//  SplashService.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import RxSwift

protocol SplashService {
	func getConfigurations() -> Observable<Configurations>
}

class SplashServiceImpl: APIClient, SplashService {
	func getConfigurations() -> Observable<Configurations> {
		return request(TMDBRouter.getConfiguration)
	}
}
