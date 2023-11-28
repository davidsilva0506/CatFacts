//
//  DateHelperTests.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//

import XCTest
@testable import CatFacts

final class DateHelperTests: XCTestCase {
 
    func testSameDayDate() {

        let now = Date()
        XCTAssertEqual(now.daysBetween(date: now), 0)
    }
    
    func testDaysBetweenDates() throws {
        
        var dateComponents = DateComponents()
        dateComponents.day = 5
        let now = Date()
        let futureDate = try XCTUnwrap(Calendar.current.date(byAdding: dateComponents, to: now))
        XCTAssertEqual(now.daysBetween(date: futureDate), 5)
    }
}
