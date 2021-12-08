//
//  SignUpViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 4/12/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
        
        nameTextField.autocapitalizationType = .none
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
        
        signUpButton.layer.masksToBounds = true
        signUpButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        signUpButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        let userName = nameTextField.text
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let uuid = UUID().uuidString
        
        // Check if any of the fields is empty
        if (userName?.isEmpty ?? true || userEmail?.isEmpty
            ?? true || userPassword?.isEmpty ?? true) {
            displayAlert(message: "All fields are required")
            return
        }
        
        // Store users in user defaults
        UserDefaults.standard.set(userName, forKey: "userName")
        // Check if email already exists
        let emailStored = UserDefaults.standard.string(forKey: "userEmail")
        if userEmail == emailStored {
            displayAlert(message: "Email already exists. Please choose another one.")
            return
        } else {
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
        }
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.set(uuid, forKey: "UUID")
        UserDefaults.standard.synchronize()
        
        // Notify user that registration was successfull
        let successAlert = UIAlertController(title: "Alert", message: "Your registration was successful. Thank you", preferredStyle: .alert)
        
        // Action when user presses ok
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        // Successful registration
        successAlert.addAction(okAction)
        self.present(successAlert, animated: true, completion: nil)
        
        // Display alert message function
        func displayAlert(message: String) {
            let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
    
//        let viewController = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//        view.window?.rootViewController = viewController
//        view.window?.makeKeyAndVisible()
    }
}
