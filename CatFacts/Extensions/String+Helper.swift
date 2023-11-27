//
//  String+Helper.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

extension String {

    
    func validText() -> String {

        return self.replacingOccurrences(of: " ", with: "").lowercased()
    }
}
