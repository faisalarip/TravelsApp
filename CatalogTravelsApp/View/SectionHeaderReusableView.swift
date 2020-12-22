//
//  SectionHeaderReusableView.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 21/12/20.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
    
    static let identifier: String = "SectionHeader"
    
    let title = UILabel()
    let subtitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .systemBackground
        
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        let stackview = UIStackView(arrangedSubviews: [separator, title, subtitle])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 10
        self.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackview.topAnchor.constraint(equalTo: topAnchor),
            stackview.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
                
        stackview.setCustomSpacing(20, after: separator)
        stackview.setCustomSpacing(20, after: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
