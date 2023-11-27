//
//  CatFactTableViewCell.swift
//  CatFacts
//
//  Created by David Silva on 27/11/2023.
//

import UIKit

class CatFactTableViewCell: UITableViewCell {
    private enum Constants {
        static let fontSize: CGFloat = 16
        static let imageHeight: CGFloat = 40
        static let imageWidth: CGFloat = 40
        static let horizontalSpace: CGFloat = 20
        static let verticalSpace: CGFloat = 4
        static let spaceBetweenImages: CGFloat = 10
        static let new = "new"
    }
    var catFactLabel = UILabel()
    var imageContainer = UIView()
    var verifiedImageView = UIImageView()
    var newFactImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.configureView()
        self.defineSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CatFactTableViewCell {


    func addSubviews() {
        
        self.imageContainer.add(self.verifiedImageView, self.newFactImageView)
        self.contentView.add(self.catFactLabel, self.imageContainer)
    }
    
    func configureView() {

        self.selectionStyle = .none
        self.catFactLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)
        self.catFactLabel.numberOfLines = 0
        self.verifiedImageView.clipsToBounds = true
        self.verifiedImageView.contentMode = .scaleAspectFit
        self.newFactImageView.clipsToBounds = true
        self.newFactImageView.contentMode = .scaleAspectFit
        self.newFactImageView.image = UIImage(named: Constants.new)
    }
    
    func defineSubviewConstraints() {
        
        self.catFactLabel.translatesAutoresizingMaskIntoConstraints = false
        self.imageContainer.translatesAutoresizingMaskIntoConstraints = false
        self.verifiedImageView.translatesAutoresizingMaskIntoConstraints = false
        self.newFactImageView.translatesAutoresizingMaskIntoConstraints = false
        self.catFactLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.verticalSpace).isActive = true
        self.catFactLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.horizontalSpace).isActive = true
        self.catFactLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.horizontalSpace).isActive = true

        self.imageContainer.topAnchor.constraint(equalTo: self.catFactLabel.bottomAnchor).isActive = true
        self.imageContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.horizontalSpace).isActive = true
        self.imageContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.horizontalSpace).isActive = true
        self.imageContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Constants.verticalSpace).isActive = true
        self.imageContainer.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
        
        self.verifiedImageView.topAnchor.constraint(equalTo: self.imageContainer.topAnchor).isActive = true
        self.verifiedImageView.leadingAnchor.constraint(equalTo: self.imageContainer.leadingAnchor).isActive = true
        self.verifiedImageView.bottomAnchor.constraint(equalTo: self.imageContainer.bottomAnchor).isActive = true
        self.verifiedImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true

        self.newFactImageView.topAnchor.constraint(equalTo: self.imageContainer.topAnchor).isActive = true
        self.newFactImageView.leadingAnchor.constraint(equalTo: self.verifiedImageView.trailingAnchor, constant: Constants.spaceBetweenImages).isActive = true
        self.newFactImageView.bottomAnchor.constraint(equalTo: self.imageContainer.bottomAnchor).isActive = true
        self.newFactImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth).isActive = true
    }
}
