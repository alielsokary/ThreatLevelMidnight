//
//  Configurations.swift
//  ThreatLevelMidnight
//
//  Created by Ali Elsokary on 17/03/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import Foundation

// MARK: - Configurations
struct Configurations: Codable {
	let images: Images?
	let changeKeys: [String]?

	enum CodingKeys: String, CodingKey {
		case images
		case changeKeys = "change_keys"
	}

	func saveUserData() -> JSONEncoder {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(self) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: "CurrentConfig")
		}
		return encoder
	}

	static func currentConfig() -> Configurations? {
		let defaults = UserDefaults.standard
		let decoder = JSONDecoder()
		guard let savedConfig = defaults.object(forKey: "CurrentConfig") as? Data else { return nil }
		guard let loadedConfig = try? decoder.decode(Configurations.self, from: savedConfig) else { return nil }
		return loadedConfig
	}

	static func remove() {
		let defaults = UserDefaults.standard
		defaults.removeObject(forKey: "CurrentConfig")
		defaults.synchronize()
	}
}

// MARK: - Images
struct Images: Codable {
	let baseURL: String?
	let secureBaseURL: String?
	let backdropSizes, logoSizes, posterSizes, profileSizes: [String]?
	let stillSizes: [String]?

	enum CodingKeys: String, CodingKey {
		case baseURL = "base_url"
		case secureBaseURL = "secure_base_url"
		case backdropSizes = "backdrop_sizes"
		case logoSizes = "logo_sizes"
		case posterSizes = "poster_sizes"
		case profileSizes = "profile_sizes"
		case stillSizes = "still_sizes"
	}
}
