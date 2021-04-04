//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var userVSuser = true
    var newMode = false
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    
    var recieverVC: LogReceiver!
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var computerTurnLabel: UILabel!
    @IBOutlet var playerTurnLabel: UILabel!
    var counter: Int = 0
    var countOfTouch: Int = 0
    @IBOutlet var movesLeft: UILabel!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private lazy var referee = Referee(gameboard: gameBoard)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        switch newMode {
        
        case true:
           
            newModeInitialState()
            
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                           
                self.currentState.addMark(at: position)
                
                
                if self.currentState.isMoveCompleted {
                    self.setNextStateNewMode()
                }
            }
            
        case false:
            
            setInitialState()
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                           
                
                self.currentState.addMark(at: position)
                print(self.counter)
                
                if self.currentState.isMoveCompleted {
                    self.counter += 1
                    self.setNextState()
                }
            }
        }


        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }            
                       
            
            self.currentState.addMark(at: position)
            
            
            if self.currentState.isMoveCompleted {
                self.counter += 1
                self.setNextState()
            }
        }
//            self.gameboardView.placeMarkView(XView(), at: position)
    }
       
  
    private func setInitialState() {

        var player: Player
        
        switch userVSuser {
        
            case true: player = .first
            case false: player = .player
        }
        
        currentState = PlayerState(player: player, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
    }
    
    func setNextState() {
        
        if let winner = referee.determineWinner() {
            currentState = GameOverState(winner: winner, gameViewController: self)
            return
        }
        
        if counter >= 9 {
            currentState = GameOverState(winner: nil, gameViewController: self)
        }
        
        if let playerState = currentState as? PlayerState {
            let nextPlayer = playerState.player.next
            currentState = PlayerState(player: nextPlayer, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: nextPlayer.markViewPrototype)
        }
        
    }
    
    func setNextStateNewMode() {
        
        if counter == 10 {
            if let winner = referee.determineWinner() {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            }
        }
        if counter == 10 {
            currentState = GameOverState(winner: nil, gameViewController: self)
        }
        
        if let playerState = currentState as? NewMode {
                        let nextPlayer = playerState.player.next
                        currentState = NewMode(player: nextPlayer, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: nextPlayer.markViewPrototype)
           recieverVC = LogReceiver(player: nextPlayer, /*gameViewController: self,*/ gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: nextPlayer.markViewPrototype)
            
            LogInvoker.shared.receiver = recieverVC
                    
        }
    }
    
    func newModeInitialState() {
        
        let player: Player = .first
        recieverVC = LogReceiver(player: player, /*gameViewController: self,*/ gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        
        LogInvoker.shared.receiver = recieverVC
        
        currentState = NewMode(player: player, gameViewController: self, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: player.markViewPrototype)
        
        
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        counter = 0
        
        switch newMode {
        case true:
            newModeInitialState()
        case false:
            setInitialState()
        }
        gameBoard.clear()
        gameboardView.clear()
        recieverVC?.restart()
        LogInvoker.shared.commands.removeAll()
        
    }
}
