//
//  CatListViewController.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import UIKit

class CatListViewController: UIViewController {
    private let viewModel: CatListViewModel
   
    init(viewModel: CatListViewModel) {

        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Cat Facts"
        
        self.viewModel.requestCatFacts()
    }
}
