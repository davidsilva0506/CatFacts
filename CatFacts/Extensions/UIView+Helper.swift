//
//  UIView+Helper.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import UIKit

extension UIView {

    func pin(to superView: UIView) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    func add(_ subviews: UIView...) {

        subviews.forEach(self.addSubview)
    }
}
