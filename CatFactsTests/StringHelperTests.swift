//
//  StringHelperTests.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//

import XCTest
@testable import CatFacts

final class StringHelperTests: XCTestCase {
 
    func testValidText() {

        let text = "cats Are fUn "
        let expectedValidText = "catsarefun"
        
        XCTAssertNotNil(text.validText())
        XCTAssertEqual(text.validText(), expectedValidText)
    }
    
    func testValidTextComparison() {
        
        let text = "caTs arefuuUUn   "
        let fact = "CATSare fuuuun"
        
        XCTAssertEqual(text.validText(), fact.validText())
    }
    
    func testValidTextWrongComparison() {
        
        let text = "caTs arefuuUUn   "
        let fact = "CATSare realy fuuuun"
        
        XCTAssertNotEqual(text.validText(), fact.validText())
    }
}
