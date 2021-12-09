//
//  File.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 7/12/21.
//

import UIKit

// used to transfer data between tabs
class Favorites {
    static let sharedFavorites = Favorites()
    var favoritesArray = [FoodTableViewCellViewModel]()
    
    func containsElement(element: FoodTableViewCellViewModel) -> Bool {
        return favoritesArray.contains(where: { $0.uri == element.uri } )
    }
    
    func indexElement(element: FoodTableViewCellViewModel) -> Int {
        return favoritesArray.firstIndex(where: { $0.uri == element.uri } ) ?? 0
    }
    
    func removeAllTypes(of: FoodTableViewCellViewModel) {
        favoritesArray.removeAll(where: { $0.uri == of.uri })
    }
}
