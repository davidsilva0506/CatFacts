//
//  CatListViewModelTests.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//

import XCTest

@testable import CatFacts

class CatListViewModelTests: XCTestCase {
    
    private enum Constants {
        
        static let expectationTimeout: TimeInterval = 1
        static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
        static let iso8601Full: DateFormatter = {
            
            let formatter = DateFormatter()
            formatter.dateFormat = Constants.dateFormat
            
            return formatter
        }()
    }
    
    var provider: CatProviderMock?
    var viewModel: CatListViewModel?
    
    override func setUp() {
        
        super.setUp()
        
        self.provider = CatProviderMock()
        
        if let provider = self.provider {
            
            self.viewModel = CatListViewModel(provider: provider)
        }
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        self.provider = nil
        self.viewModel = nil
    }
    
    func testLoadFacts() throws {
        
        var expectedFacts: [CatFact]?
        var expectedError: Error?
        
        let expectation = self.expectation(description: "Load mocked cat facts with success")
        
        self.provider?.getFacts(completion: { facts, error in
            
            expectedFacts = facts
            expectedError = error
            
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: Constants.expectationTimeout)
        
        XCTAssertNil(expectedError)
        XCTAssertNotNil(expectedFacts)
        XCTAssertEqual(expectedFacts?.count, 3)
    }
    
    func testLoadAndFirstFact() throws {
        
        var expectedFirstFact: CatFact?
        var expectedError: Error?
        
        let expectation = self.expectation(description: "Load mocked cat facts with success")
        
        self.provider?.getFacts(completion: { facts, error in
            
            expectedFirstFact = facts?.first
            expectedError = error
            
            expectation.fulfill()
        })
        
        self.wait(for: [expectation], timeout: Constants.expectationTimeout)
        
        XCTAssertNil(expectedError)
        XCTAssertNotNil(expectedFirstFact)
        XCTAssertEqual(expectedFirstFact?.text, "Cats are nice.")
        XCTAssertEqual(expectedFirstFact?.status.verified, false)
        XCTAssertEqual(expectedFirstFact?.status.sentCount, 5)
        
        let expectedDate = Constants.iso8601Full.date(from: "2022-05-10T01:55:11 -02:00")
        XCTAssertEqual(expectedFirstFact?.createdAt, expectedDate)
    }
    
    func testLoadAndFilterFacts() throws {
        
        self.viewModel?.requestCatFacts()
        
        XCTAssertNotNil(self.viewModel?.filteredFacts)
        XCTAssertEqual(self.viewModel?.filteredFacts.count, 3)
        
        self.viewModel?.filterCurrentFacts(searchTerm: "Cats are")
        
        XCTAssertEqual(self.viewModel?.filteredFacts.count, 2)
        
        self.viewModel?.filterCurrentFacts(searchTerm: "Cats are c")
        
        XCTAssertEqual(self.viewModel?.filteredFacts.count, 1)
        
        self.viewModel?.restoreCurrentFacts()
        
        XCTAssertEqual(self.viewModel?.filteredFacts.count, 3)
    }
}
