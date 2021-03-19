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
			print("tv: ", tv.element)
		}.disposed(by: bag)

		APIClient.getSeason(season: 1).subscribe { (_) in
		}.disposed(by: bag)

		APIClient.getEpisode(season: 1, episode: 1).subscribe { (_) in
		}.disposed(by: bag)

	}

}
