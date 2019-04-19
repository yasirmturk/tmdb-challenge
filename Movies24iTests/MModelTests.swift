//
//  MModelTests.swift
//  Movies24iTests
//
//  Created by Yasir M Turk on 19/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import XCTest
@testable import Movies24i

class MModelTests: XCTestCase {

    let dateFormatter = MConfig.Servers.dateFormatter

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Testing decoding of static data
    func testServerDateDecoding() {
        let date = dateFormatter.date(from: "2019-03-23")
        XCTAssertNotNil(date)
    }

    /// Testing decoding of stub data
    func testStubDecodingPopular() {
        let stubData = TMDbMovieAPI.popular.data
        XCTAssertNotNil(stubData)

        let model = try? stubData!.decode(type: MovieResult.self)
        XCTAssertNotNil(model)

        let movies = model!.results
        XCTAssertEqual(movies.count, 5)
        XCTAssertEqual(movies[0].id, 287947)
        XCTAssertEqual(movies[0].title, "Shazam!")

        let date1 = dateFormatter.date(from: "2019-03-23")
        XCTAssertEqual(movies[0].releaseDate, date1)

        let date2 = dateFormatter.date(from: "2019-04-10")
        XCTAssertEqual(movies[1].releaseDate, date2)
    }

    /// Testing query methods
    func testQueries() {
        let stubData = TMDbMovieAPI.popular.data
        XCTAssertNotNil(stubData)

        let model = try? stubData!.decode(type: MovieResult.self)
        XCTAssertNotNil(model)
    }

}
