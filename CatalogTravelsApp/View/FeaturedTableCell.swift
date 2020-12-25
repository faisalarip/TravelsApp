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
    var app: App?
    
    let tagline = UILabel()
    let name = UILabel()
    let subheading = UILabel()
    let imageView = UIImageView()
    let favoriteButton = UIButton(type: .custom)
    let favoriteImage = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    let favoriteImageFill = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    
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
        
        favoriteButton.isSelected = false
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton(_:)), for: .touchUpInside)
        
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
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: separator)
        stackView.setCustomSpacing(15, after: secondStackView)
    }
    
    @objc private func didTapFavoriteButton(_ sender: UIButton) {
        print("Fav button has tapped \(sender.isSelected)")
        
        if !sender.isSelected {
            sender.isSelected = true
            sender.zoomInWithEasing(duration: 0.3, easingOffset: 0.3)
            sender.setImage(favoriteImageFill, for: .selected)
        } else {
            sender.isSelected = false
            sender.zoomOutWithEasing(duration: 0.3, easingOffset: 0.3)
            sender.setImage(favoriteImage, for: .selected)
        }
        
    }
    
    func configureCellLayout(with app: App) {
        self.app = app
        
        tagline.text = app.tagline
        name.text = app.name
        subheading.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
