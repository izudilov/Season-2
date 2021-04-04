//
//  PlayerState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 25.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerState: GameState {
    
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private weak var gameViewController: GameViewController?
    private weak var gameBoard: Gameboard?
    private weak var gameBoardView: GameboardView?    
    public let markViewPrototype: MarkView
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            gameViewController?.playerTurnLabel.isHidden = true
            gameViewController?.computerTurnLabel.isHidden = true
            gameViewController?.movesLeft.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
            gameViewController?.playerTurnLabel.isHidden = true
            gameViewController?.computerTurnLabel.isHidden = true
            gameViewController?.movesLeft.isHidden = true
        case .computer:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            gameViewController?.playerTurnLabel.isHidden = true
            gameViewController?.computerTurnLabel.isHidden = false
            gameViewController?.movesLeft.isHidden = true
            computerTurn()
        case .player:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            gameViewController?.playerTurnLabel.isHidden = false
            gameViewController?.computerTurnLabel.isHidden = true
            gameViewController?.movesLeft.isHidden = true
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        
 
        //Logger.log(action: .placeMarkView(markViewPrototype.copy(), at: position))

        
        guard let boardView = gameBoardView, boardView.canPlaceMarkView(at: position) else { return }
        
        boardView.placeMarkView(markViewPrototype.copy(), at: position)
        gameBoard?.setPlayer(player, at: position)
        
        isMoveCompleted = true
    }
    
    func computerTurn () {
        
        let position = gameBoard?.computerPositions()
        //Logger.log(action: .addMark(player: player, position: position!, board: gameBoard!))
        
        guard let boardView = gameBoardView, boardView.canPlaceMarkView(at: position!) else { return }
        
        boardView.placeMarkView(markViewPrototype.copy(), at: position!)
        gameBoard?.setPlayer(player, at: position!)
        gameViewController?.counter += 1
        isMoveCompleted = true
        gameViewController?.setNextState()
    }

    
}
