//
//  SeasonViewModelTests.swift
//  ThreatLevelMidnightTests
//
//  Created by Ali Elsokary on 08/11/2021.
//  Copyright © 2021 mag. All rights reserved.
//

import XCTest
@testable import TLM

class SeasonViewModelTests: XCTestCase {

	var crew: Crew!
	var episode: Episode!
	var season: Season!

	var sut: SeasonViewModel!

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

		season = Season(id: 1,
						seasonNumber: 1,
						name: "name",
						overview: "overview",
						episodeCount: 2,
						posterPath: "path",
						airDate: "date",
						episodes: [episode])

		sut = SeasonViewModel(season: season)
    }

    override func tearDownWithError() throws {
		super.tearDown()

		crew = nil
		episode = nil
		season = nil
		sut = nil
    }

    func test_seasonNumber_Equals_seasonNumber() throws {
		XCTAssertEqual(sut.number, 1)
    }

	func test_seasonPoster_Equals_seasonPoster() throws {
		XCTAssertEqual(sut.image, "https://image.tmdb.org/t/p/original" + "path")
	}
}
