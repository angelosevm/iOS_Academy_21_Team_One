//
//  ViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 23/11/21.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // search controller for typing a custom query
    private let searchVC = UISearchController(searchResultsController: nil)
    
    private var hits = [RecipeLinks]()
    private var viewModels = [FoodTableViewCellViewModel]()
    private var index : Int?
    
    override func viewDidLoad() {
        // setup the view
        super.viewDidLoad()
        title = "Recipes"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.applyGradient(isVertical: true, colorArray: [.systemRed,.systemCyan])
        tableView.applyGradient(isVertical: true, colorArray: [.systemRed,.systemCyan])
        createSearchBar()
        
        // Default search when launching app
        getData("Main")
}
    
    // when the search button is clicked, perform an API call
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // make sure text is not empty
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        // trim white spaces and new lines in input text
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        // Fill the viewModels with data
        getData(query)
    }
    
    // use the API caller to tranfer data into the cell view model
    func getData(_ query: String) {
        APICaller.shared.getRecipes(searchTerm: query) { [weak self] result in
            switch result {
            case.success(let response):
                self?.hits = response.hits
                self?.viewModels = response.hits.compactMap({
                    FoodTableViewCellViewModel(
                        title: $0.recipe.label,
                        subtitle: $0.recipe.dishType?[0] ?? "no dish type",
                        imageURL: URL(string: $0.recipe.image),
                        time: $0.recipe.totalTime == 0 ? 30 : $0.recipe.totalTime ?? 30,
                        calories: $0.recipe.calories,
                        servings: $0.recipe.yield,
                        ingredients: $0.recipe.ingredientLines,
                        recipeURL: $0.recipe.url
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }

            case.failure(let error):
                print(error)
            }
        }
    }
    
    // show the search bar as a navigation bar item
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    // segue to next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //self.navigationItem.title = "Main View"

        if segue.identifier == "RecipeDetails" {
            let nextVC = segue.destination as! RecipeDetails
            // transfer recipe details to nextVC
            guard let index = index else { return }
            nextVC.recipeDetails.append(viewModels[index])
        }
    }
    
    // -MARK: Table functions
    
    // Table frame equal to the entire view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // anonymous closure pattern for table
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FoodTableViewCell.self, forCellReuseIdentifier: FoodTableViewCell.identifier)
        return table
    }()
    
    // number of table rows is equal to the number of recipes we get back
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    // create a cell and configure it using the FoodTableViewCell class
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.identifier, for: indexPath) as? FoodTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    // when selecting a recipe, transfer user to recipe website using SafariServices
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // the recipe we select is at index
        index = indexPath.row
        // go to custom details page
        performSegue(withIdentifier: "RecipeDetails", sender: nil)
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}

