//
//  SplashViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import Combine

class SplashViewController: UIViewController {

	private let viewModel: SplashViewModel!

    private var cancellables = Set<AnyCancellable>()

    required init?(coder: NSCoder, viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.start()
		setupBindings()
    }

}

// MARK: - Setup Bindings

private extension SplashViewController {
    func setupBindings() {
        viewModel.$alertMessage
            .compactMap { $0 }
            .sink { message in
                self.showAlert(message: message)
            }.store(in: &cancellables)

        viewModel.$isLoading
            .sink { [weak self] isLoading in
                isLoading ? self?.showProgress() : self?.hideProgress()
            }
            .store(in: &cancellables)

        //		viewModel.noInternet
        //			.subscribe { [weak self] noInternet in
        //				if noInternet.element! {
        //
        //					self?.showAlert(message: NSLocalizedString("API_ERROR_No_Connection", comment: ""), handler: { _ in
        //						self?.viewModel.start()
        //					})
        //				}
        //			}.disposed(by: disposeBag)
        //	}
    }
}
