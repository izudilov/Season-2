//
//  GameState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 25.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    
    var isMoveCompleted: Bool { get }
    
    func begin()
    func addMark(at position: GameboardPosition)
    func computerTurn()
}
