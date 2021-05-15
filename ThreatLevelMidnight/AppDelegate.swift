//
//  AppDelegate.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 6/28/20.
//  Copyright © 2020 mag. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		configureNetworkLogger()
		return true
	}

	func configureNetworkLogger() {
		#if DEBUG
		NetworkActivityLogger.shared.level = .debug
		NetworkActivityLogger.shared.startLogging()
		#endif
	}

}
