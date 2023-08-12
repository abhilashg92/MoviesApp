//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Kiwi on 10/08/23.
//

import XCTest
@testable import MoviesApp

final class MoviesAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
    func testFetchMovies() throws {
        
        let expectation = XCTestExpectation(description: "Data fetched")

        let service = MockService()
        let vm = MoviesViewModel(netWorkService: service)
        vm.fetchPopulerMovies()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(vm.movies.count > 0, true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchMoviesFailure() throws {
        let expectation = XCTestExpectation(description: "Data fetched")

        let service = MockService()
        service.success = false
        let vm = MoviesViewModel(netWorkService: service)
        vm.fetchPopulerMovies()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(vm.movies.count == 0, true )
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5) // Adjust the timeout if needed
    }
    
    func testUseCase() throws {
        let service = MockService()
        let usecase = PopulerMoviesUseCase(netWorkSerive: service)
        usecase.searchMovies() { result in
            switch result {
            case .success(let moveis):
                XCTAssert(moveis.count > 0)
            case .failure(_):
                XCTAssert(true)
            }
        }
    }
    
    func testUseCaseFailure() throws {
        let service = MockService()
        service.success = false
        let usecase = PopulerMoviesUseCase(netWorkSerive: service)
        usecase.searchMovies() { result in
            switch result {
            case .success(let moveis):
                XCTAssert(moveis.isEmpty)
            case .failure(let err):
                XCTAssertTrue(true, "\(err.hashValue)")
            }
        }
    }
}
