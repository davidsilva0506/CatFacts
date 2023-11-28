//
//  CatProviderMock.swift
//  CatFactsTests
//
//  Created by David Silva on 28/11/2023.
//

import XCTest
@testable import CatFacts

class CatProviderMock: XCTestCase, CatProvider {
    
    func getFacts(completion: @escaping ([CatFact]?, Error?) -> Void) {
        
        do {
            
            let facts: [CatFact] = try JSONHelper.load(from: "facts")
            completion(facts, nil)

        } catch {
            
            completion(nil, error)
        }
    }
}
