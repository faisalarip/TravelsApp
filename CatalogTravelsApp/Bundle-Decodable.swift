//
//  Bundle-Decodable.swift
//  CatalogTravelsApp
//
//  Created by Faisal Arif on 20/12/20.
//

import Foundation

extension Bundle {
    
    func decode<T: Decodable>(_ type: T.Type, from file: String ) -> T {
        
        guard let fileURL = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load url from \(file) bundle")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed load data \(file) from bundle")
        }
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else { fatalError("Failed to decode from data \(data) ")
        }
        
        return loaded
    }
    
}
