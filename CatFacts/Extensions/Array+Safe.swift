//
//  Array+Safe.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

public extension Array {

    subscript(safe index: Index) -> Element? {

        return index < endIndex && index >= startIndex ? self[index] : nil
    }
}
