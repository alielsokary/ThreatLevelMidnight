//
//  Coordinator.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 29/11/2023.
//  Copyright © 2023 mag. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
