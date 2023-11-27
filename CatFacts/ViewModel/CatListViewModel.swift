//
//  CatListViewModel.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation

protocol CatListViewModelDelegate: AnyObject {

    func didLoad(_ viewModel: Any, success: Bool, error: Error?)
    func didUpdate(_ viewModel: Any)
}

final class CatListViewModel: NSObject {
    public weak var delegate: CatListViewModelDelegate?
    private var orginalFacts = [CatFact]()
    var filteredFacts = [CatFact]()
    private unowned let provider: CatProvider

    init(provider: CatProvider) {

        self.provider = provider
    }
    
    func requestCatFacts() {
        
        self.provider.getFacts { facts, error in
            guard error == nil,
                let facts = facts else {
                self.delegate?.didLoad(self, success: false, error: error)
                return
            }
            self.orginalFacts = facts
            self.filteredFacts = facts
            self.delegate?.didLoad(self, success: true, error: nil)
        }
    }
    
    func filterCurrentFacts(searchTerm: String) {
        
        guard searchTerm.count > 0 else { return }
        self.filteredFacts = self.orginalFacts
        self.filteredFacts = self.orginalFacts.filter { fact in
            fact.text.validText().contains(searchTerm.validText())
        }
        self.delegate?.didUpdate(self)
    }
    
    func restoreCurrentFacts() {
        
        self.filteredFacts = self.orginalFacts
        self.delegate?.didUpdate(self)
    }
}
