//
//  Settings.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit
import NVActivityIndicatorView

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var loggingOutLabel: UILabel!
    
    private let indicatorView: NVActivityIndicatorView = NVActivityIndicatorView(
        frame: CGRect(x: 185, y: 725, width: 50, height: 50),
        type: NVActivityIndicatorType.ballBeat,
        color: .black,
        padding: 0.5
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS"
        loggingOutLabel.text = "Logging you out..."
        loggingOutLabel.isHidden = true
        // Retrieve user data from user defaults
        let nameStored = userDefaults.string(forKey: "userName")
        let emailStored = userDefaults.string(forKey: "userEmail")
        let isLoggedIn = userDefaults.bool(forKey: "isUserLoggedIn")
        
        if isLoggedIn {
            self.userNameLabel.text = nameStored
            self.userEmailLabel.text = emailStored
            actionButton.setTitle("Log out", for: .normal)
        } else {
            self.userNameLabel.text = ""
            self.userEmailLabel.text = ""
            actionButton.setTitle("Log in", for: .normal)
        }
    }
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Retrieve user data from user defaults
        let nameStored = userDefaults.string(forKey: "userName")
        let emailStored = userDefaults.string(forKey: "userEmail")
        let isLoggedIn = userDefaults.bool(forKey: "isUserLoggedIn")
        
        // If a user is logged in, their name and email appears, as well as the option to logout
        // otherwise, they can only login
        if isLoggedIn {
            self.userNameLabel.text = nameStored
            self.userEmailLabel.text = emailStored
            actionButton.setTitle("Log out", for: .normal)
        } else {
            self.userNameLabel.text = ""
            self.userEmailLabel.text = ""
            actionButton.setTitle("Log in", for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(indicatorView)
        actionButton.layer.masksToBounds = true
        actionButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        actionButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        actionButton.tintColor = .white
        actionButton.layer.cornerRadius = 25
        actionButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        let isLoggedIn = userDefaults.bool(forKey: "isUserLoggedIn")
        // if user is logged in, set log in state to false
        if isLoggedIn {
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
        }
        
        // animation for logging out
        UIView.animate(withDuration: 2.5, animations: animation) { _ in
            self.indicatorView.stopAnimating()
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TestingView")
            self.view.window?.rootViewController = viewController
            self.view.window?.makeKeyAndVisible()
        }
        

    }
    
    func animation() {
        self.indicatorView.startAnimating()
        self.loggingOutLabel.isHidden = false
        self.loggingOutLabel.layer.opacity = 0
        self.loggingOutLabel.transform = CGAffineTransform(translationX: 0,
                                                             y: self.loggingOutLabel.bounds.origin.y - 30)
        self.loggingOutLabel.layer.opacity = 1
    }
}
