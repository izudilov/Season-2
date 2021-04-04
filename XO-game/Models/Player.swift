//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    case player
    
    var next: Player {
        switch self {
        case .first: return .second
        case .second: return .first
        case .computer: return .player
        case .player: return .computer
        }
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second:
            return OView()
        case .computer:
            return ComputerView()
        case .player:
            return XView()
        }
    }
}
