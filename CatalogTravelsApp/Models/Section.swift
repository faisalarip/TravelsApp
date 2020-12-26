//
//  Section.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [Travel]
}
