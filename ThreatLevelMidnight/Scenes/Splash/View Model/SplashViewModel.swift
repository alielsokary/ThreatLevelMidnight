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
	let noInternet = BehaviorSubject<Bool>(value: false)
	private let _alertMessage = PublishSubject<String>()

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
				guard let error = error as? APIError else { return }
				switch error {
				case .noInternet:
					self?.noInternet.onNext(true)
				default:
					self?._alertMessage.onNext(error.localizedDescription)
				}
			}).disposed(by: disposeBag)
	}
}