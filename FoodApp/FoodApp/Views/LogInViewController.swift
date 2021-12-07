//
//  LogInViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 3/12/21.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var userEmailTextfield: UITextField!
    @IBOutlet weak var userPasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logInButton.layer.masksToBounds = true
        logInButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        logInButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        logInButton.tintColor = .white
        logInButton.layer.cornerRadius = 25
        logInButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func logIn(_ sender: Any) {
//        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//        view.window?.rootViewController = viewController
//        view.window?.makeKeyAndVisible()
                
        let userEmail = userEmailTextfield.text
        let userPassword = userPasswordTextfield.text
        
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