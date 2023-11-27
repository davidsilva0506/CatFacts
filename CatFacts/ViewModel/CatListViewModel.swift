//
//  CatListViewModel.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

final class PackListViewModel: NSObject {
    private unowned let provider: CatProvider

    init(provider: CatProvider) {

        self.provider = provider
    }
}
