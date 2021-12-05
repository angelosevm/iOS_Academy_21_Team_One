//
//  StartingViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 3/12/21.
//

import UIKit



class StartingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var continueAsGuestButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // define colors
        let colorPink = UIColor(red: 243/255, green: 129/255, blue: 129/255, alpha: 0.95).cgColor
        let colorPurple = UIColor(red: 249/255, green: 120/255, blue: 249/255, alpha: 0.98).cgColor
        // create the gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.colors = [colorPink, colorPurple]
        gradient.locations =  [-0.5, 1.5]
        // create animation
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [UIColor.white.cgColor, colorPink]
        animation.toValue = [UIColor.systemMint.cgColor, colorPurple]
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        // add the animation to the gradient
        gradient.add(animation, forKey: nil)
        
        // add the gradient to the view
        self.view.layer.insertSublayer(gradient, at: 0)
        
        //view.applyGradient(isVertical: true, colorArray: [.orange1Color,.orange2Color])
        titleLabel.shadowColor = .customTextBlack
        titleLabel.font = UIFont.robotoBold(size: 40)
        titleLabel.shadowOffset = CGSize(width: 2, height: 3)
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowRadius = 25

        logInButton.layer.masksToBounds = true
        logInButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        logInButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        logInButton.tintColor = .white
        logInButton.layer.cornerRadius = 25
        logInButton.layer.cornerCurve = .continuous

        signUpButton.layer.masksToBounds = true
        signUpButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        signUpButton.backgroundColor = .white
        signUpButton.tintColor = .orange1Color
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.cornerCurve = .continuous
        signUpButton.layer.borderWidth = 2.5
        signUpButton.layer.borderColor = CGColor(red: 255/255, green: 140/255, blue: 43/255, alpha: 1)

        continueAsGuestButton.titleLabel?.font = UIFont.montserratRegular(size: 16)
    }
    
    @IBAction func guestButton(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
}
