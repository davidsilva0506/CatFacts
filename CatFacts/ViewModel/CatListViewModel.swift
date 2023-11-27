//
//  CatListViewModel.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

protocol CatListViewModelDelegate: AnyObject {

    func viewModel(_ viewModel: Any, catFacts: [CatFact]?, error: Error?)
}

final class CatListViewModel: NSObject {
    public weak var delegate: CatListViewModelDelegate?
    private unowned let provider: CatProvider

    init(provider: CatProvider) {

        self.provider = provider
    }
    
    func requestCatFacts() {
        
        self.provider.getFacts { facts, error in
            
            guard error == nil else {
                
                self.delegate?.viewModel(self, catFacts: nil, error: error)
                return
            }
            
            self.delegate?.viewModel(self, catFacts: facts, error: nil)
        }
    }
}
