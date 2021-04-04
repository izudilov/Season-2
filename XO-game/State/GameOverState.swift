//
//  GameOverState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 25.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameOverState: GameState {
    
   
    
    var isMoveCompleted: Bool = false
    
    public let winner: Player?
    private weak var gameViewController: GameViewController?
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    func begin() {
        
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = getWinnerName(for: winner) + " Won"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        gameViewController?.playerTurnLabel.isHidden = true
        gameViewController?.computerTurnLabel.isHidden = true
        gameViewController?.movesLeft.isHidden = true
        
        
        //Logger.log(action: .endGame(withWinner: winner))
    }
    
    func computerTurn() {}
    
    func addMark(at position: GameboardPosition) {}
    
    private func getWinnerName(for player: Player) -> String {
        switch player {
        case .first:
            return "1st Player"
        case .second:
            return "2nd Player"
        case .computer:
            return "Computer"
        case .player:
            return "Player"
        }
    }
}
