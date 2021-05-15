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
	let isLoading = BehaviorSubject<Bool>(value: false)
	private let _alertMessage = PublishSubject<String>()
	let noInternet = BehaviorSubject<Bool>(value: false)

	let service: SplashService

	let alertMessage: Observable<String>

	init(service: SplashService) {
		self.service = service
		self.alertMessage = _alertMessage.asObserver()
	}

	func start() {
		self.isLoading.onNext(true)
		self.noInternet.onNext(false)
		service.getConfigurations()
			.subscribe(onNext: { [weak self] (config) in
			self?.isLoading.onNext(false)
			_ = config.saveUserData()
			self?.configLoaded.onNext(true)
		}, onError: { [weak self] error in
			self?.isLoading.onNext(false)
			if let error = error as? APIError {
				if error == .noInternet {
					self?.noInternet.onNext(true)
				}
			}
		}).disposed(by: disposeBag)
	}
}
