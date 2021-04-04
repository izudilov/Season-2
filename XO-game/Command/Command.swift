//
//  LogCommand.swift
//  XO-game
//
//  Created by Evgenii Semenov on 26.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol Command {
    
    var action: LogAction { get }
    func execute() -> String
}


class LogCommand: Command {
    func execute() -> String {
        return "Hello"
    }
    
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    /*private var logMessage: String {
        switch action {
        case let .addMark(player: player, position: position):
            return "\(player) добавил маркер в позицию \(position)"
            
        case let .endGame(withWinner: winner):
            if let winner = winner {
                return "\(winner) выиграл"
            } else {
                return "Нет победителя"
            }
            
        case .restartGame:
            return "Рестарт"
        default:
               return "Default"
        }
        
       
    }*/
    
    /*func execute() -> String {
        //return logMessage
    }*/
}
