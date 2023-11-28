//
//  UIViewHelperTests.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//

import XCTest
@testable import CatFacts

final class UIViewHelperTests: XCTestCase {
 
    func testMultipleAddAndRemoveAll() {
        
        let parentView = UIView()
        let subView = UIView()
        let subView2 = UIView()
        let subView3 = UIView()
        
        parentView.add(subView, subView2)
        
        XCTAssertEqual(parentView.subviews.count, 2)
        
        parentView.add(subView3)
        
        XCTAssertEqual(parentView.subviews.count, 3)
    }
}
