//
//  RecipeDetailsViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit

class RecipeDetails: UIViewController {
    
    var customName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe Details"
        self.view.backgroundColor = .systemMint
        self.title = customName
        // create details for the recipe
        //test lines
        
    }
}
