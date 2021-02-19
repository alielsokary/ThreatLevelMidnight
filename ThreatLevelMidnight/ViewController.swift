//
//  ViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 6/28/20.
//  Copyright © 2020 mag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

	private let bag = DisposeBag()
	override func viewDidLoad() {
		super.viewDidLoad()
		APIClient.getTVShow().subscribe { (tv) in
			print(tv)
		}.disposed(by: bag)

	}

}
