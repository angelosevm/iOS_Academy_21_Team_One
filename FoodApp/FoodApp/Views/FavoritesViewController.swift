//
//  FavoritesViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModels = [FoodTableViewCellViewModel]()
    private var index : Int?
    private let emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FAVORITES"
        view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        
        emptyLabel.isHidden = false

        emptyLabel.text = "No saved recipes"
        emptyLabel.textAlignment = .center
        emptyLabel.font = .montserratRegular(size: 20)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = Favorites.sharedFavorites.favoritesArray
        print(viewModels.count)
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModels.count == 0 {
            emptyLabel.isHidden = false
        }
        else { emptyLabel.isHidden = true }
    }
    
    // Table frame equal to the entire view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        emptyLabel.frame = view.bounds
        view.addSubview(emptyLabel)
    }
    
    // segue to next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoritesRecipeDetails" {
            let nextVC = segue.destination as! RecipeDetails
            // transfer recipe details to nextVC
            guard let index = index else { return }
            nextVC.recipeDetails.append(viewModels[index])
        }
    }
    
    // MARK: Table functions
    
    // anonymous closure pattern for table
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FoodTableViewCell.self, forCellReuseIdentifier: FoodTableViewCell.identifier)
        return table
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as? FoodTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    
    // when selecting a recipe, transfer user to recipe details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // the recipe we select is at index
        index = indexPath.row
        // go to custom details page
        performSegue(withIdentifier: "FavoritesRecipeDetails", sender: nil)
    }
    
}

