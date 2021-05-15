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
    }

}
