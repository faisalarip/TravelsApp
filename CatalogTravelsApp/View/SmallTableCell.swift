//
//  SmallTableCell.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 21/12/20.
//

import UIKit

class SmallTableCell: UICollectionViewCell, ConfiguringCell {
    static var reuseableIdentifier: String = "SmallTableCell"
    
    let name = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
                
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let stackview = UIStackView(arrangedSubviews: [imageView, name])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.axis = .horizontal
        stackview.spacing = 10
        contentView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureCellLayout(with app: App) {
        name.text = app.name
        imageView.image = UIImage(named: app.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
