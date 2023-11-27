//
//  CatFactTableViewCell+Configuration.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import UIKit

extension CatFactTableViewCell {
    private enum Constants {
        static let verified = "verified"
        static let unverified = "unverified"
    }
    
    func configure(catFactText: String, isVerified: Bool, isNew: Bool) {

        self.catFactLabel.text = catFactText
        let imageName = isVerified ? Constants.verified : Constants.unverified
        self.verifiedImageView.image = UIImage(named: imageName)
        self.newFactImageView.isHidden = !isNew
    }
}
