//
//  MyAdd.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 07.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

@IBDesignable
class MyAdd: UIImageView {
    
    @IBInspectable var shadowOffset: CGSize = CGSize() {
        didSet {
            self.layer.shadowOffset = shadowOffset
      }
    }
    
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
         }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
}
