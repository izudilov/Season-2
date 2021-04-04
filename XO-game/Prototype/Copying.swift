//
//  Copying.swift
//  XO-game
//
//  Created by Evgenii Semenov on 26.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
    func copy() -> Self
}

extension Copying where Self: AnyObject {
    
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
