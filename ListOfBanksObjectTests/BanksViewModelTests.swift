//
//  BanksViewModelTests.swift
//  ListOfBanksObjectTests
//
//  Created by Lesly Higuera on 26/10/22.
//

import XCTest
@testable import ListOfBanksObject

class BanksViewModelTests: XCTestCase {

    // MARK: - Private Properties
    private var requestExpectation: XCTestExpectation?
    // MARK: - Subject under test
    private var viewModel: BanksViewModel!
    // MARK: - Mock
    private var repositoryMock: BanksRepositoryMock!

    // MARK: - Set up & Tear Down

    override func setUp() {
        super.setUp()
        repositoryMock = BanksRepositoryMock()
        viewModel = BanksViewModel(repository: repositoryMock)
    }

    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        viewModel = nil
    }

    // MARK: - Tests getCategories

    func testGetCategories() {
        // Given
        repositoryMock.banks = BankFake.values
        // When
        getBanks()
        // Then
        XCTAssertEqual(requestExpectation?.expectationDescription, ResponseExpectation.ok.rawValue)
    }

}

private extension BanksViewModelTests {
    
    // MARK: - getProducts
    
    func getBanks() {
        requestExpectation = expectation(description: ResponseExpectation.go.rawValue)
        viewModel.success = {
            self.requestExpectation?.expectationDescription = ResponseExpectation.ok.rawValue
            self.requestExpectation?.fulfill()
        }
        viewModel.getBanks()
        if let requestExpectation = requestExpectation {
            wait(for: [requestExpectation], timeout: 1)
        }
    }

}
