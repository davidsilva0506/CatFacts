//
//  Date+Helper.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

extension Date {

    func daysBetween(date: Date) -> Int {

        return Calendar.current.dateComponents([.day], from: self, to: date).day ?? 0
    }
}
