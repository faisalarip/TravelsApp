//
//  TopPopularCell.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import UIKit

class FeaturedTableCell: UICollectionViewCell, ConfiguringCell {
    
    static var reuseableIdentifier: String = "TopPopularCell"

    private let tagline = UILabel()
    private let name = UILabel()
    private let subheading = UILabel()
    private let imageView = UIImageView()
    private let favoriteButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .systemBackground
        
        tagline.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        tagline.textColor = .systemBlue
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subheading.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subheading.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let favoriteImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
                
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.contentVerticalAlignment = .fill
        
        let firstStackView = UIStackView(arrangedSubviews: [name, favoriteButton])
        firstStackView.axis = .horizontal
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let secondStackView = UIStackView(arrangedSubviews: [tagline, firstStackView, subheading])
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.axis = .vertical
        secondStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [separator, secondStackView, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 25),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            firstStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: separator)
        stackView.setCustomSpacing(15, after: secondStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellLayout(with app: App) {
        tagline.text = app.tagline
        name.text = app.name
        subheading.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
}
