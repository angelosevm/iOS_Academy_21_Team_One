//
//  File.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 7/12/21.
//

import UIKit

class Favorites {
    static let sharedFavorites = Favorites()
    var favoritesArray = [FoodTableViewCellViewModel]()
    
    func containsElement(element: FoodTableViewCellViewModel) -> Bool {
        return favoritesArray.contains(where: { $0.id == element.id } )
    }
    
    func indexElement(element: FoodTableViewCellViewModel) -> Int {
        return favoritesArray.firstIndex(where: { $0.id == element.id } ) ?? 0
    }
}
