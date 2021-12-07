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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        let nameStored = userDefaults.string(forKey: "userName")
        let emailStored = userDefaults.string(forKey: "userEmail")
        self.userNameLabel.text = nameStored;
        self.userEmailLabel.text = emailStored;
        print("\(String(describing: userDefaults.string(forKey: "UUID")))")
        //nick: C6607EF8-CD6D-4F33-897F-7CA0A5BBFBAE
        //test1: BE5A82BE-6662-4B90-9D79-FA3899AD7359
    }
}
