//
//  EpisodeOfTheDayViewController.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 30/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import UIKit
import Combine

class EpisodeOfTheDayViewController: UIViewController {

    private let coordinator: EpisodeOfTheDayCoordinator!
    private let viewModel: EpisodeOfTheDayViewModel!

    private var cancellables = Set<AnyCancellable>()

    required init?(coder: NSCoder, coordinator: EpisodeOfTheDayCoordinator, viewModel: EpisodeOfTheDayViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
