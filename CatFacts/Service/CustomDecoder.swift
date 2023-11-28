//
//  CustomDecoder.swift
//  CatFacts
//
//  Created by David Silva on 28/11/2023.
//

import Foundation

class CustomDecoder: JSONDecoder {

    private enum Constants {

        static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss Z"
    }

    static let iso8601Full: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        
        return formatter
      }()

    override init() {
        
        super.init()
        dateDecodingStrategy = .formatted(CustomDecoder.iso8601Full)
    }
}
