//
//  LogInViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 3/12/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let colorShade1 = UIColor(red: 249/255, green: 202/255, blue: 100/255, alpha: 0.98).cgColor
        let colorShade4 = UIColor(red: 249/255, green: 121/255, blue: 100/255, alpha: 0.98).cgColor
        // create the gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.startPoint = CGPoint(x:0.0, y:0.0)
        gradient.endPoint = CGPoint(x:1.0, y:1.0)
        gradient.colors = [colorShade1, colorShade4]
        gradient.locations =  [-0.5, 1.5]
        
        // add the gradient to the view
        self.view.layer.insertSublayer(gradient, at: 0)
        
        logInButton.layer.masksToBounds = true
        logInButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        logInButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        logInButton.tintColor = .white
        logInButton.layer.cornerRadius = 25
        logInButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
        // get email and password
        let emailStored = UserDefaults.standard.string(forKey: "userEmail")
        let passwordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        // check if email entered exists
        if emailStored == userEmail {
            // check if password entered exists
            if passwordStored == userPassword {
                // Login
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
            } else { displayAlert(message: "Password is incorrect")
                return
            }
        } else { displayAlert(message: "Email is incorrect")
            return
        }
        
        // Function that displays alert messages
        func displayAlert(message: String) {
            let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
}
