//
//  APIError.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 14/10/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

enum APIError: Int, Error {
	case noInternet
	case tlmn_unauthorized = 401
	case tlmn_forbidden = 403
	case tlmn_notFound = 404
	case tlmn_internalServerError = 500
	case unknown
}

extension APIError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .noInternet:
			return NSLocalizedString("API_ERROR_No_Connection", comment: "")
		default:
			return NSLocalizedString("Error", comment: "")
		}
	}
}
