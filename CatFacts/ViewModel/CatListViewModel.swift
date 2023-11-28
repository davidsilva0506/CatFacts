//
//  CatListViewModel.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

protocol CatListViewModelDelegate: AnyObject {

    func viewModel(_ viewModel: Any, loaded: Bool, error: Error?)
    func viewModel(_ viewModel: Any, updated: Bool)
}

final class CatListViewModel: NSObject {
    
    public weak var delegate: CatListViewModelDelegate?
    
    var filteredFacts = [CatFact]()
    private var orginalFacts = [CatFact]()
    
    private unowned let provider: CatProvider

    init(provider: CatProvider) {

        self.provider = provider
    }
    
    func requestCatFacts() {
        
        self.provider.getFacts { facts, error in
            
            guard error == nil,
                let facts = facts else {
                    
                self.delegate?.viewModel(self, loaded: false, error: error)
                return
            }

            self.orginalFacts = facts
            self.filteredFacts = facts
            
            self.delegate?.viewModel(self, loaded: true, error: nil)
        }
    }
    
    func filterCurrentFacts(searchTerm: String) {
        
        guard searchTerm.count > 0 else {
            
            self.delegate?.viewModel(self, updated: false)
            return
        }
        
        self.filteredFacts = self.orginalFacts.filter { fact in
           
            fact.text.validText().contains(searchTerm.validText())
        }
        
        self.delegate?.viewModel(self, updated: true)
    }
    
    func restoreCurrentFacts() {
        
        self.filteredFacts = self.orginalFacts
        self.delegate?.viewModel(self, updated: true)
    }
}
