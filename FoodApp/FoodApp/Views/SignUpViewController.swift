//
//  SignUpViewController.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 4/12/21.
//

import UIKit
import NVActivityIndicatorView

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    
    private let indicatorView: NVActivityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x: 185, y: 350, width: 50, height: 50),
        type: NVActivityIndicatorType.ballBeat,
        color: .black,
        padding: 0.5
    )
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"), style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
        backbutton.tintColor = .black
        navigationItem.leftBarButtonItem = backbutton
        
        registrationLabel.text =
        """
        Your registration was successful.
        Thank you!
        """
        registrationLabel.isHidden = true
        registrationLabel.textColor = UIColor(red: 37/255, green: 184/255, blue: 0/255, alpha: 0.72)
        
        nameTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
    }
    
    // MARK: ViewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.autocapitalizationType = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no

        UIView.animate(withDuration: 1) {
            self.greetingLabel.text = "Nice to meet you"
            self.greetingLabel.layer.opacity = 0
            self.greetingLabel.layer.opacity = 1
        }
    }
    
    // MARK: ViewDidLayoutSubviews
    
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
        
        self.view.addSubview(indicatorView)
        
        signUpButton.layer.masksToBounds = true
        signUpButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        signUpButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        signUpButton.tintColor = .white
        signUpButton.layer.cornerRadius = 25
        signUpButton.layer.cornerCurve = .continuous
    }
    
    // hide keyboard when pressing on the outside screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Sign Up Button
    
    @IBAction func signUp(_ sender: Any) {
        signUpButton.isEnabled = false
        
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
        // Check if email already exists
        let emailStored = UserDefaults.standard.string(forKey: "userEmail")
        if userEmail == emailStored {
            displayAlert(message: "Email already exists. Please choose a different one.")
            return
        } else {
            UserDefaults.standard.set(userName, forKey: "userName")
            UserDefaults.standard.set(userEmail, forKey: "userEmail")
        }
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.set(uuid, forKey: "UUID")
        UserDefaults.standard.synchronize()
        
        // animation at successful registration
        UIView.animate(withDuration: 2.5, animations: animation) { _ in
            self.indicatorView.stopAnimating()
            self.registrationLabel.isHidden = true
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    // Display alert message function if email exists
    func displayAlert(message: String) {
        let alertMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertMessage.addAction(okAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    func animation() {
        self.indicatorView.startAnimating()
        self.registrationLabel.isHidden = false
        self.registrationLabel.layer.opacity = 0.7
        self.registrationLabel.transform = CGAffineTransform(translationX: 0,
                                                             y: self.registrationLabel.bounds.origin.y - 15)
        self.registrationLabel.layer.opacity = 0.9
    }
    
}

