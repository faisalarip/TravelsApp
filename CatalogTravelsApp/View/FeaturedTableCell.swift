//
//  TopPopularCell.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import UIKit

class FeaturedTableCell: UICollectionViewCell, ConfiguringCell {
    
    static var reuseableIdentifier: String = "TopPopularCell"
    
    var completion: ((Result<Section, Error>) -> Void)?
    var travel: Travel?
    
    let tagline = UILabel()
    let name = UILabel()
    let subheading = UILabel()
    let imageView = UIImageView()
    let favoriteButton = UIButton(type: .custom)
    let favoriteImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    
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
                
        favoriteButton.isUserInteractionEnabled = true
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
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
//            firstStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: separator)
        stackView.setCustomSpacing(15, after: secondStackView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.isSelected = false
    }
    
    func configureCellLayout(with travel: Travel) {
        self.travel = travel
        
        tagline.text = travel.tagline
        name.text = travel.name
        subheading.text = travel.subheading
        imageView.image = UIImage(named: travel.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
