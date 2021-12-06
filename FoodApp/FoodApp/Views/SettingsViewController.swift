//
//  Settings.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 28/11/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    
    
    @IBOutlet weak var PersonEmail: UILabel!
    
    
    @IBOutlet weak var themeSegment: UISegmentedControl!
    
    let userDefaults = UserDefaults.standard
    let THEME_KEY = "themeKey"
    let DARK_THEME = "DarkTheme"
    let LIGHT_THEME = "LightTheme"
    let RED_THEME = "RedTheme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        updateTheme()
    }
    
    
    func updateTheme() {
        
        let theme = userDefaults.string(forKey: THEME_KEY)
        if (theme == LIGHT_THEME) {
            themeSegment.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.white
        }
        
        else if (theme == DARK_THEME) {
            themeSegment.selectedSegmentIndex = 1
            view.backgroundColor = UIColor.systemGray3
        }
        
        else if (theme == RED_THEME) {
            themeSegment.selectedSegmentIndex = 2
            view.backgroundColor = UIColor.systemTeal
        }
    }
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        switch themeSegment.selectedSegmentIndex
        {
        case 0:
            userDefaults.set(LIGHT_THEME, forKey: THEME_KEY)
            
        case 1:
            userDefaults.set(DARK_THEME, forKey: THEME_KEY)
            
        case 2:
            userDefaults.set(RED_THEME, forKey: THEME_KEY)
            
        default:
            userDefaults.set(LIGHT_THEME, forKey: THEME_KEY)
        }
        updateTheme()
        
    }
    
    
    
}
