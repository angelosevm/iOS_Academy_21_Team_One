//
//  Colors.swift
//  FoodApp
//
//  Created by Nikolaos Mikrogeorgiou on 26/11/21.
//

import Foundation
import UIKit

extension UIColor {
    static var offWhite = UIColor(red: 225/255, green: 225/255, blue: 235/255, alpha: 1)
    
}

// colors that go well together in linear gradient
extension UIColor {
    static let darkStart = UIColor(red: 50/255, green: 60/255, blue: 65/255, alpha: 1)
    
}

extension UIColor {
    static let darkEnd = UIColor(red: 25/255, green: 25/255, blue: 30/255, alpha: 1)
    }


extension UIColor {
    static let lightStart = UIColor(red: 60/255, green: 160/255, blue: 240/255, alpha: 1)
    }

extension UIColor {
    static let lightEnd = UIColor(red: 30/255, green: 80/255, blue: 120/255, alpha: 1)
}

extension UIColor {
    static let customGray = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
}

extension UIColor {
    static let customTextGray = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
}

extension UIColor {
    static let customTextBlack = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
}

// Create a linear gradient
// usage: someView.applyGradient(isVertical: true/false, colorArray: [.firstcolor, .secondcolor])
extension UIView {
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// for creating the orange color with gradient using first and second Colors
extension UIColor {
    static let orange1Color = UIColor(red: 255/255, green: 140/255, blue: 43/255, alpha: 1)
    static let orange2Color = UIColor(red: 255/255, green: 99/255, blue: 34/255, alpha: 1)
}
