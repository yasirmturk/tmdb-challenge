//
//  TMDbAPITests.swift
//  Movies24iTests
//
//  Created by Yasir M Turk on 19/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import XCTest
@testable import Movies24i
@testable import MCoreKit

class TMDbAPITests: XCTestCase {

    let stub = StubProvider<TMDbMovieAPI>()
    let alamofire = AlamofireProvider<TMDbMovieAPI>()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Testing stub api call
    func testStubCall() {
        let expectation = XCTestExpectation(description: "Get popular movies from json")

        let service = TMDbMovieService(stub)
        service.fetchPopular(onSuccess: { result in

            let movies = result.results

            XCTAssertEqual(movies.count, 5)
            XCTAssertEqual(movies[0].id, 287947)
            XCTAssertEqual(movies[0].title, "Shazam!")
            XCTAssertEqual(movies[0].genres.count, 3)
            XCTAssertEqual(movies[1].id, 456740)
            XCTAssertEqual(movies[1].poster, "/nUXCJMnAiwCpNPZuJH2n6h5hGtF.jpg")

            expectation.fulfill()
        }, onError: { error in
            XCTFail("fetchPopular: \(error.localizedDescription)")

            expectation.fulfill()
        })

        let expectation2 = XCTestExpectation(description: "Movie details from json")
        service.fetchDetails(287947, onSuccess: { movie in
            XCTAssertNotNil(movie)
            XCTAssertEqual(movie.title, "Shazam!")
            XCTAssertEqual(movie.genres.count, 3)

            expectation2.fulfill()
        }, onError: { error in
            XCTFail("fetchDetails: \(error.localizedDescription)")

            expectation2.fulfill()
        })

        wait(for: [expectation, expectation2], timeout: 1.0)
    }

    /// Testing live api call
    func testLiveCallPopular() {
        let expectation = XCTestExpectation(description: "Get popular movies")

        let service = TMDbMovieService(alamofire)
        // API Success test
        service.fetchPopular(onSuccess: { result in
            XCTAssertGreaterThanOrEqual(result.results.count, 0)

            expectation.fulfill()
        }, onError: { error in
            XCTFail("fetchPopular: \(error.localizedDescription)")

            expectation.fulfill()
        })

        // API Failure test
        let expectation2 = XCTestExpectation(description: "Invalid movie details")
        service.fetchDetails(0, onSuccess: { movie in
            XCTAssertNil(movie)

            expectation2.fulfill()
        }, onError: { error in
            XCTAssertNotNil(error as? TMDbAPIError)

            expectation2.fulfill()
        })

        wait(for: [expectation, expectation2], timeout: 3.0)
    }

}
