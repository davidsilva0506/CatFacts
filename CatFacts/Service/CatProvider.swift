//
//  CatProvider.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

protocol CatProvider: AnyObject {


    func getFacts(completion: @escaping ([CatFact]?, Error?) -> Void)
}
