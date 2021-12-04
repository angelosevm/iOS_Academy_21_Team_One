//
//  CategoryViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit
import SafariServices

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // search controller for typing a custom query
    private let searchVC = UISearchController(searchResultsController: nil)
    var typeSearched: String = "Main course"
    
    private var storedHits = [FoodTableViewCellViewModel]()
    private var viewModels = [FoodTableViewCellViewModel]()
    private var index : Int?
    private var currentNumber, totalNumber : Int?
    private var query: String = "Main"
    private var urlConst: String = ""
    
    override func viewDidLoad() {
        // setup the view
        super.viewDidLoad()
        self.navigationItem.title = "\(typeSearched)"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // custom back button
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
        
        createSearchBar()
        
        // Default search when launching app
        getData("Main", checkIfConst: false, urlConst: "")
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
        getData(query, checkIfConst: false, urlConst: "")
        // test lines
    }
    
    // use the API caller to tranfer data into the cell view model
    func getData(_ query: String, checkIfConst: Bool, urlConst: String) {
        APICaller.shared.getRecipes(searchTerm: query, type: typeSearched,
                                    hasType: true,
                                    const: checkIfConst, urlConst: urlConst) { [weak self] result in
            switch result {
            case.success(let response):
                self?.currentNumber = response.to
                self?.totalNumber = response.count
                self?.urlConst = response._links.next?.href ?? ""
                self?.viewModels = response.hits.compactMap({
                    FoodTableViewCellViewModel(
                        title: $0.recipe.label,
                        subtitle: $0.recipe.dishType?[0] ?? "no dish type",
                        imageURL: URL(string: $0.recipe.image),
                        time: $0.recipe.totalTime == 0 ? 30 : $0.recipe.totalTime ?? 30,
                        calories: $0.recipe.calories,
                        servings: $0.recipe.yield,
                        ingredients: $0.recipe.ingredientLines,
                        recipeURL: $0.recipe.url,
                        shareAs: $0.recipe.shareAs
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    //let indexPath = IndexPath(row: 0, section: 0)
                    // catch NSRange Error when scrolling an empty tableView
//                    if self?.viewModels.count != 0 {
//                        self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                    }
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
        
        if segue.identifier == "CategoryRecipeDetails" {
            let nextVC = segue.destination as! RecipeDetails
            // transfer recipe details to nextVC
            guard let index = index else { return }
            nextVC.recipeDetails.append(viewModels[index])
        }
    }
    
    // MARK: Table functions
    
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
        performSegue(withIdentifier: "CategoryRecipeDetails", sender: nil)
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    
    // show next page of results
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 10 {
            if currentNumber != totalNumber {
                getData(query, checkIfConst: true, urlConst: urlConst)
            }
            else { return }
        }
    }
    
}
