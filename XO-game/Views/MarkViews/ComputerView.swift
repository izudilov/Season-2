//
//  ComputerView.swift
//  XO-game
//
//  Created by user179996 on 31.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

import UIKit

public class ComputerView: MarkView {
    
    internal override func updateShapeLayer() {
        super.updateShapeLayer()      
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = 0.3 * min(bounds.width, bounds.height)
        shapeLayer.path = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: 330 * CGFloat.pi / 180,
                                       endAngle: -30 * CGFloat.pi / 180,
                                       clockwise: false).cgPath
        let red = UIColor(red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        shapeLayer.strokeColor = red.cgColor
    }
}
