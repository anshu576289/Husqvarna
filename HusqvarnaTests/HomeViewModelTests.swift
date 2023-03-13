//
//  HomeViewModelTests.swift
//  HusqvarnaTests
//
//  Created by Anshu Kumar Ray on 12/03/23.
//

import Combine
import XCTest

@testable import Husqvarna

class HomeViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    func testAppConfigInitialization() {
        let mockService = MockService()
        let viewModel = HomeViewModel(moviesService: mockService)
        let expectation = XCTestExpectation(description: "Initializing App Config")
        
        viewModel.$topRatedMovies.dropFirst().sink { state in
            XCTAssertEqual(AppConfiguration.appConfig?.images?.secureBaseUrl, "https://image.tmdb.org/t/p/")
            XCTAssertTrue(((AppConfiguration.appConfig?.images?.posterSizes?.isEmpty) != nil))
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadingMoviesFlagTrueOnLaunch() {
        let mockService = MockService()
        let viewModel = HomeViewModel(moviesService: mockService)
        let expectation = XCTestExpectation(description: "Initializing Movies Data")
        viewModel.$isLoadingMovies.sink { state in
            XCTAssertTrue(((viewModel.isLoadingMovies)))
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testErrorFlagFalseOnMoviesLoad() {
        let mockService = MockService()
        let viewModel = HomeViewModel(moviesService: mockService)
        let expectation = XCTestExpectation(description: "Initializing Movies Data")
        viewModel.$topRatedMovies.sink { state in
            XCTAssertFalse(((viewModel.shouldShowError)))
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
    }
}

extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}

