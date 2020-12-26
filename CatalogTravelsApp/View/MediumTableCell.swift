//
//  MediumTableCell.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 21/12/20.
//

import UIKit

class MediumTableCell: UICollectionViewCell, ConfiguringCell {
    
    static var reuseableIdentifier: String = "MediumTableCell"
    
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    let shareButton = UIButton()
    let shareImage = UIImage(systemName: "arrowshape.turn.up.right.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .light))?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        shareButton.isUserInteractionEnabled = true
        shareButton.setImage(shareImage, for: .normal)
        shareButton.imageView?.contentMode = .scaleAspectFill
        shareButton.contentHorizontalAlignment = .fill
        shareButton.contentVerticalAlignment = .fill
        
        let textStackView = UIStackView(arrangedSubviews: [name, subtitle])
        textStackView.axis = .vertical
        textStackView.spacing = 5
        
        let imageWithTextStackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        imageWithTextStackView.axis = .horizontal
        imageWithTextStackView.setCustomSpacing(15, after: imageView)
        
        let finalStackView = UIStackView(arrangedSubviews: [imageWithTextStackView, shareButton])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.alignment = .center
        finalStackView.spacing = 10
        
        contentView.addSubview(finalStackView)
        
        NSLayoutConstraint.activate([

            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            
            shareButton.heightAnchor.constraint(equalToConstant: 24),
            shareButton.widthAnchor.constraint(equalToConstant: 24),
            
            finalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            finalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            finalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            finalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellLayout(with travel: Travel) {
        name.text = travel.name
        subtitle.text = travel.subheading
        imageView.image = UIImage(named: travel.image)
    }

}
