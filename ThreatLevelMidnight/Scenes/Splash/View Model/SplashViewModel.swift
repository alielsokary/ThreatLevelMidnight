//
//  SplashViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel {

	private let disposeBag = DisposeBag()

	let configLoaded = PublishSubject<Bool>()

	let service: SplashService

	init(service: SplashService) {
		self.service = service
	}

	func start() {
		service.getConfigurations()
			.subscribe { [weak self] (config) in
			_ = config.element?.saveUserData()
				self?.configLoaded.onNext(true)
		}.disposed(by: disposeBag)
	}
}
