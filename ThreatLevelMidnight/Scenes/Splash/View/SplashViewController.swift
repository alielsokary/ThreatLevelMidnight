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
		viewModel.alertMessage
			.subscribe(onNext: { [weak self] in self?.showAlert(message: $0) })
			.disposed(by: disposeBag)

		viewModel.isLoading
			.subscribe { [weak self] isLoading in
				isLoading ? self?.showProgress() : self?.hideProgress()
			}.disposed(by: disposeBag)

		viewModel.noInternet
			.subscribe { [weak self] noInternet in
				if noInternet.element! {

					self?.showAlert(message: NSLocalizedString("API_ERROR_No_Connection", comment: ""), handler: { _ in
						self?.viewModel.start()
					})
				}
			}.disposed(by: disposeBag)
	}
}
