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
