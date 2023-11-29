//
//  EpisodeViewModelTests.swift
//  ThreatLevelMidnightTests
//
//  Created by Ali Elsokary on 08/11/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import XCTest
@testable import TLM

class EpisodeViewModelTests: XCTestCase {

	var crew: Crew!
	var episode: Episode!

	var sut: EpisodeViewModel!

    override func setUpWithError() throws {
		super.setUp()
		crew = Crew(id: 1,
					name: "name",
					originalName: "name",
					department: Department(rawValue: "dep"),
					job: "job",
					creditID: "id",
					adult: true,
					gender: 1,
					knownForDepartment: Department(rawValue: "act"),
					popularity: 5.0,
					profilePath: "path",
					character: "char",
					order: 1)

		episode = Episode(id: 1,
						  episodeNumber: 1,
						  seasonNumber: 1,
						  name: "name",
						  overview: "overview",
						  productionCode: "code",
						  airDate: "22",
						  crew: [crew],
						  guestStars: [crew],
						  stillPath: "path",
						  voteAverage: 5.0,
						  voteCount: 1)
		sut = EpisodeViewModel(episode: episode)
    }

    override func tearDownWithError() throws {
		super.tearDown()

		crew = nil
		episode = nil
		sut = nil
    }

	func test_seasonNumber_equals_seasonNumber() throws {
		XCTAssertEqual(sut.seasonNumber, 1)
	}

	func test_episodeNumber_equals_episodeNumber() throws {
		XCTAssertEqual(sut.number, 1)
	}

    func test_episodeName_equals_episodeName() throws {
		XCTAssertEqual(sut.name, "name")
    }

	func test_episodeOverview_equals_episodeOverview() throws {
		XCTAssertEqual(sut.overview, "overview")
	}

}
