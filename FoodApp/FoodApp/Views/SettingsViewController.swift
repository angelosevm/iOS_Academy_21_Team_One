//
//  Settings.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTINGS"
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
            print("\(String(describing: userDefaults.string(forKey: "UUID")))")
            actionButton.setTitle("Log out", for: .normal)
        } else {
            self.userNameLabel.text = ""
            self.userEmailLabel.text = ""
            actionButton.setTitle("Log in", for: .normal)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        actionButton.layer.masksToBounds = true
        actionButton.titleLabel?.font = UIFont.robotoBold(size: 20)
        actionButton.applyGradient(isVertical: false, colorArray: [.orange1Color, .orange2Color])
        actionButton.tintColor = .white
        actionButton.layer.cornerRadius = 25
        actionButton.layer.cornerCurve = .continuous
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {

        let isLoggedIn = userDefaults.bool(forKey: "isUserLoggedIn")
        if isLoggedIn {
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
        }
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TestingView")
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
    }
}
