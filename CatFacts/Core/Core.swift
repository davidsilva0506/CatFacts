//
//  Core.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

final class Core: NSObject {
    let service: FactsApi

    init(service: FactsApi) {
        
        self.service = service

        super.init()
    }
}
