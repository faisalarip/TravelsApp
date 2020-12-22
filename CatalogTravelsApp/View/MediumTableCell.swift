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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let stackViewText = UIStackView(arrangedSubviews: [name, subtitle])
        stackViewText.axis = .vertical
        stackViewText.spacing = 10
        
        let stackview = UIStackView(arrangedSubviews: [imageView, stackViewText])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 15
        
        contentView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackview.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellLayout(with app: App) {
        name.text = app.name
        subtitle.text = app.subheading
        imageView.image = UIImage(named: app.image)
    }

}
