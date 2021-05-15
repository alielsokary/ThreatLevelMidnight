//
//  SplashViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {

	var viewModel: SplashViewModel!
	private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.start()
		setupBindings()
    }

}

// MARK: - Setup Bindings

private extension SplashViewController {
	func setupBindings() {
		viewModel.isLoading
			.subscribe(onNext: { [weak self] isLoading in
				isLoading ? self?.showProgress() : self?.hideProgress()
			})
			.disposed(by: disposeBag)

		viewModel.noInternet
			.subscribe { [weak self] noInternet in
				if noInternet.element! {
					self?.showAlert(message: R.string.localizable.api_ERROR_No_Connection(), handler: { _ in
						self?.viewModel.start()
					})
				}
			}.disposed(by: disposeBag)
	}
}
