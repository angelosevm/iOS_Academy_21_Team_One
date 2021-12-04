//
//  RecipeDetailsViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit
import SafariServices

// connects to RecipeDetailsViewController on Main storyboard. Shows details for each recipe clicked
class RecipeDetails: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var darkImage: UIImageView!
    @IBOutlet weak var recipeType: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var shareLink: UIButton!
    @IBOutlet weak var ingredientsTable: UITableView!
    
    var recipeDetails: [FoodTableViewCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .offWhite
        
        // custom back button
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .white
        navigationItem.leftBarButtonItem = backbutton
        
        // fill labels and image
        ingredientsTable.dataSource = self
        ingredientsTable.delegate = self
        recipeTitle.text = recipeDetails[0].title
        recipeImage.image = UIImage(data: recipeDetails[0].imageData!)
        darkImage.backgroundColor = .black
        darkImage.layer.opacity = 0.25
        recipeType.text = recipeDetails[0].subtitle.uppercased()
        timeLabel.text = String(Int(recipeDetails[0].time)) + " minutes"
        caloriesLabel.text = String(Int(recipeDetails[0].calories)/(recipeDetails[0].servings))
        servingsLabel.text = String(recipeDetails[0].servings) + " people"
        ingredientsTitleLabel.text = "INGREDIENTS"
        ingredientsTable.reloadData()
        
        // icons
        let clockView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        clockView.image = UIImage(named: "ic_duration")
        clockView.translatesAutoresizingMaskIntoConstraints = false
        let calorieView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        calorieView.image = UIImage(named: "calorie")
        calorieView.translatesAutoresizingMaskIntoConstraints = false
        calorieView.tintColor = .customGray
        let servingsView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        servingsView.image = UIImage(named: "ic_recipes_grey")
        servingsView.translatesAutoresizingMaskIntoConstraints = false
        
        caloriesLabel.addSubview(calorieView)
        calorieView.centerYAnchor.constraint(equalTo: caloriesLabel.centerYAnchor, constant: 0).isActive = true
        calorieView.rightAnchor.constraint(equalTo: caloriesLabel.leftAnchor, constant: 46).isActive = true
        timeLabel.addSubview(clockView)
        clockView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor, constant: 0).isActive = true
        clockView.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: 12).isActive = true
        servingsLabel.addSubview(servingsView)
        servingsView.centerYAnchor.constraint(equalTo: servingsLabel.centerYAnchor, constant: 0).isActive = true
        servingsView.rightAnchor.constraint(equalTo: servingsLabel.leftAnchor, constant: 20).isActive = true
        
    }
    
    // table view shows ingredient list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails[0].ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientCell
        // show image and a single ingredient for each cell
        cell.ingredientIcon.image = UIImage(named: "ic_circle")
        cell.ingredientLabel.text = recipeDetails[0].ingredients[indexPath.row]
        
        return cell
        
    }
    
    // when hitting the "View instructions" button go to the recipe website
    @IBAction func viewInstructions(_ sender: UIButton) {
        
        let recipeWebsitePath = recipeDetails[0].recipeURL
        
        guard let url = URL(string: recipeWebsitePath) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @IBAction func shareRecipe(_ sender: UIButton) {
        
//        let bounds = UIScreen.main.bounds
//        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
//        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
        
        let text = recipeTitle
        let image = recipeImage
        let myWebsite = URL(string: recipeDetails[0].recipeURL)
        let shareAll = [text! , image! , myWebsite!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}
