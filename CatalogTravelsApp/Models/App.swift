//
//  App.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import Foundation

protocol ConfiguringCell {
    static var reuseableIdentifier: String { get }
    func configureCellLayout(with app: App)
}

struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
