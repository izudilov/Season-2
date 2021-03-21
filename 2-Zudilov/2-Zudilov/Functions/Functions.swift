//
//  Functions.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import UIKit

class AllFunctions {
    
    func setGradientBackground (view: UIViewController) {
        let colorTop =  UIColor(red: 212.0/255.0, green: 63.0/255.0, blue: 141.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 2.0/255.0, green: 80.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.view.bounds
        view.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
