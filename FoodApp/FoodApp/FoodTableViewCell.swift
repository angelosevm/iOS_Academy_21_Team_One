//
//  FoodTableViewCell.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 23/11/21.
//

import UIKit

// Hold imageView data and url to be cached when downloaded so that it doesn't redownload when scrolling offscreen
class FoodTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    let time: Double
    let calories: Double
    let servings: Int
    let ingredients: [String]
    let recipeURL: String
    
    init(
        title: String,
        subtitle: String,
        imageURL: URL?,
        time: Double,
        calories: Double,
        servings: Int,
        ingredients: [String],
        recipeURL: String
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.time = time
        self.calories = calories
        self.servings = servings
        self.ingredients = ingredients
        self.recipeURL = recipeURL
    }
}

class FoodTableViewCell: UITableViewCell {

    static let identifier = "FoodTableViewCell"
    
    // 6 table view (subviews) for each table cell
    // Title Label (name of the recipe)
    private let foodTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratMedium(size: 20)
        label.textColor = .customTextBlack
        return label
    }()
    
    // Subtitle Label (the dish type of the recipe)
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratRegular(size: 16)
        label.textColor = .customTextGray
        return label
    }()
    
    // Time Label (the recipe time to make attribute)
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratLight(size: 20)
        label.textColor = .customTextGray
        return label
    }()
    
    // Calories Label (the amount of calories for the recipe)
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratLight(size: 20)
        label.textColor = .customTextGray
        return label
    }()
    
    // Servings Label (the amount of servings (=yield))
    private let servingsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .montserratLight(size: 20)
        label.textColor = .customTextGray
        return label
    }()
    
    // Image (recipe image)
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Create subviews on initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(foodTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(foodImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(servingsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // configure cell elements
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10))
        contentView.backgroundColor = .offWhite
        
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
        
        // label frames and settings
        foodTitleLabel.frame = CGRect(
              x: 10,
              y: contentView.frame.size.height - 112,
              width: contentView.frame.size.width - 20,
              height: 50
        )
        foodTitleLabel.textAlignment = .justified
        
        subtitleLabel.frame = CGRect(
              x: 10,
              y: contentView.frame.size.height - 150,
              width: contentView.frame.size.width,
              height: 50
        )
        
        foodImageView.frame = CGRect(
              x: 0,
              y: 0,
              width: contentView.frame.size.width,
              height: contentView.frame.size.height - 150
        )
        
        timeLabel.frame = CGRect(
              x: 25,
              y: contentView.frame.size.height - 65,
              width: 160,
              height: 50
        )
        //timeLabel.backgroundColor = .systemPurple
        timeLabel.textAlignment = .center
        timeLabel.addSubview(clockView)
        clockView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor, constant: 0).isActive = true
        clockView.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: 20).isActive = true
        
        caloriesLabel.frame = CGRect(
              x: 185,
              y: contentView.frame.size.height - 65,
              width: 75,
              height: 50
        )
        //caloriesLabel.backgroundColor = .systemTeal
        caloriesLabel.textAlignment = .center
        caloriesLabel.addSubview(calorieView)
        calorieView.centerYAnchor.constraint(equalTo: caloriesLabel.centerYAnchor, constant: 0).isActive = true
        calorieView.rightAnchor.constraint(equalTo: caloriesLabel.leftAnchor, constant: 16).isActive = true
        
        servingsLabel.frame = CGRect(
              x: 260,
              y: contentView.frame.size.height - 65,
              width: 125,
              height: 50
        )
        //servingsLabel.backgroundColor = .systemMint
        servingsLabel.textAlignment = .center
        servingsLabel.addSubview(servingsView)
        servingsView.centerYAnchor.constraint(equalTo: servingsLabel.centerYAnchor, constant: 0).isActive = true
        servingsView.rightAnchor.constraint(equalTo: servingsLabel.leftAnchor, constant: 17).isActive = true
        
    }
    
    // Nil everything for next cell
    override func prepareForReuse() {
        super.prepareForReuse()
        foodTitleLabel.text = nil
        subtitleLabel.text = nil
        foodImageView.image = nil
        timeLabel.text = nil
        caloriesLabel.text = nil
        servingsLabel.text = nil
    }
    
    func configure(with viewModel: FoodTableViewCellViewModel) {
        // Fill labels
        foodTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle.uppercased()
        //let attachment = NSTextAttachment()
        //attachment.image = UIImage(systemName: "time")
        timeLabel.text = String(Int(viewModel.time)) + " minutes"
        //timeLabel.text.append(attachment)
        caloriesLabel.text = String(Int(viewModel.calories)/(viewModel.servings))
        servingsLabel.text = String(viewModel.servings) + " people"
        
        // Configure image
        if let data = viewModel.imageData {
            foodImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            // Fetch image
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.foodImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

