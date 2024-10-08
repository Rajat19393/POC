//
//  MyTableViewCell.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 05/10/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var fact: Row? {
        didSet {
            factTitleLabel.text = fact?.title ?? Constants.notAvailable
            factDescriptionLabel.text = fact?.description ?? Constants.notAvailable
            if let imageURLString =  fact?.imageHref, let url = URL(string:  imageURLString) {
                factImageView.loadImage(at: url)
            } else {
                factImageView.image = UIImage(named: Constants.placeHolder)
            }
        }
    }
    
    let factImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: Constants.placeHolder) // Set a placeholder image
        imageView.backgroundColor = UIColor.teal // Background color as a placeholder
        return imageView
    }()
    
    let factTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.text = Constants.notAvailable // Placeholder text
        return label
    }()
    
    let factDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = Constants.notAvailable // Placeholder text
        label.textColor = .lightGray // Change text color to indicate it's description
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(factImageView)
        contentView.addSubview(factTitleLabel)
        contentView.addSubview(factDescriptionLabel)
        
        // Disable autoresizing mask translation
        factImageView.translatesAutoresizingMaskIntoConstraints = false
        factTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        factDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        factImageView.contentMode = .scaleAspectFill
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Image View Constraints
            factImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            factImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            factImageView.heightAnchor.constraint(equalToConstant: 50),
            factImageView.widthAnchor.constraint(equalToConstant: 50),
            
            // Title Label Constraints
            factTitleLabel.leadingAnchor.constraint(equalTo: factImageView.trailingAnchor, constant: 8),
            factTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            factTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            factTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            // Description Label Constraints
            factDescriptionLabel.leadingAnchor.constraint(equalTo: factTitleLabel.leadingAnchor),
            factDescriptionLabel.trailingAnchor.constraint(equalTo: factTitleLabel.trailingAnchor),
            factDescriptionLabel.topAnchor.constraint(equalTo: factTitleLabel.bottomAnchor, constant: 4),
            factDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            factDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        self.factImageView.image = nil
        factTitleLabel.text = nil
        factDescriptionLabel.text = nil
        self.factImageView.cancelImageLoad()
    }
}
