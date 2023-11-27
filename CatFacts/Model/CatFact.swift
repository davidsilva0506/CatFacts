//
//  Cat.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import Foundation

struct CatFact: Decodable {
    let status: CatStatus
    let text: String
    let createdAt: Date
}
