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
        APICaller.shared.getRecipes(searchTerm: "Main") { [weak self] result in
            switch result {
            case.success(let hits):
                self?.hits = hits
                self?.viewModels = hits.compactMap({
                    FoodTableViewCellViewModel(
                        title: $0.recipe.label,
                        subtitle: $0.recipe.dishType?[0] ?? "no dish type",
                        imageURL: URL(string: $0.recipe.image),
                        time: $0.recipe.totalTime ?? 0.0,
                        calories: $0.recipe.calories,
                        servings: $0.recipe.yield
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
    
    // when the search button is clicked, perform an API call
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Fill the viewModels with data
        APICaller.shared.getRecipes(searchTerm: query) { [weak self] result in
            switch result {
            case.success(let hits):
                self?.hits = hits
                self?.viewModels = hits.compactMap({
                    FoodTableViewCellViewModel(
                        title: $0.recipe.label,
                        subtitle: $0.recipe.dishType?[0] ?? "no dish type",
                        imageURL: URL(string: $0.recipe.image),
                        time: $0.recipe.totalTime ?? 0,
                        calories: $0.recipe.calories,
                        servings: $0.recipe.yield
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
            guard let index = index else {return}
            nextVC.customName = hits[index].recipe.label
        }
    }
    

    
    // Table frame equal to the entire view
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
        
    
    // -MARK: Table functions
    
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
        
        // open recipe page in safari browser
        let hit = hits[indexPath.row]

        guard let url = URL(string: hit.recipe.url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)

        // or go to custom details page
        //performSegue(withIdentifier: "RecipeDetails", sender: nil)
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}

