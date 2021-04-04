//
//  LogReceiver.swift
//  XO-game
//
//  Created by Evgenii Semenov on 26.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogReceiver {
    
    //private weak var gameViewController: GameViewController?
    var gameBoard: Gameboard?
    var gameBoardView: GameboardView?
    var markViewPrototype: MarkView?
    
    init(player: Player, /*gameViewController: GameViewController,*/ gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        //self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    
    func addNewMark(_ markView: MarkView, at position: GameboardPosition, player: Player) {
        DispatchQueue.main.async {
            switch player {
            case .first:
                self.markViewPrototype = XView()
                self.gameBoardView?.placeMarkViewNewMode(self.markViewPrototype!.copy(), at: position)
            case .second:
                self.markViewPrototype = OView()
                self.gameBoardView?.placeMarkViewNewMode(self.markViewPrototype!.copy(), at: position)
            default:
                print("No game")
            }
        }
    }
    
    func setPlayer(_ player: Player, at position: GameboardPosition) {
        gameBoard?.setPlayer(player, at: position)
    }
    
    
    func restart () {
        gameBoard?.clear()
        gameBoardView?.clear()
    }
}
