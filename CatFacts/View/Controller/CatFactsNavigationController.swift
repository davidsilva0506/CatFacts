//
//  CatFactsNavigationController.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import Foundation
import UIKit

class CatFactsNavigationController: UINavigationController {
    
    private enum Constants {
        
        static let fontSize: CGFloat = 20
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .systemBackground
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.prefersLargeTitles = true
    }
}
