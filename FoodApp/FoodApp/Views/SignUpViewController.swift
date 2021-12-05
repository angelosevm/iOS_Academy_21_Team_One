//
//  SignUpViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 4/12/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
        
        emailTextField.keyboardType = .emailAddress
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signUpButton.layer.masksToBounds = true
        signUpButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        signUpButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func signUp(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
}
