//
//  UIViewController+Extensions.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 15/05/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import PKHUD
import UIKit

extension UIViewController {

	// MARK: - Loading Indicator

	func showProgress() {
		HUD.show(.progress)
	}

	func hideProgress() {
		HUD.hide()
	}

	func showMessage(_ message: String) {
		HUD.flash(.labeledError(title: nil, subtitle: message), delay: 1.5)
	}

	// MARK: - UIAlertController

	func showAlert(withTitle title: String?, message: String?) {
		showAlert(withTitle: title, message: message, handler: nil)
	}

	func showAlert(withTitle title: String?, message: String?, handler: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default, handler: handler)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(action)
		alert.addAction(cancelAction)
		present(alert, animated: true, completion: nil)
	}

	func showAlert(message: String) {
		let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alertController, animated: true)
	}

	func showAlert(message: String, handler: ((UIAlertAction) -> Void)?) {
		let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
		present(alertController, animated: true)
	}

	func showAlert(withError error: Error, handler: ((UIAlertAction) -> Void)? = nil) {
		showAlert(withTitle: "Error", message: error.localizedDescription, handler: handler)
	}

}
