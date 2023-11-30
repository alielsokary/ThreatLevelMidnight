//
//  SplashViewModel.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {

	private let service: SplashService!
    private var cancellables = Set<AnyCancellable>()

    @Published var configLoaded: Bool = false
    @Published var isLoading: Bool = false
    @Published var alertMessage: String?

	init(service: SplashService) {
		self.service = service
	}

	func start() {
        isLoading = true
        service.getConfigurations()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.alertMessage = error.errorDescription
                }
                self?.isLoading = false
        } receiveValue: { [weak self] configurations in
            _ = configurations.saveUserData()
            self?.configLoaded = true
        }.store(in: &cancellables)
	}
}
