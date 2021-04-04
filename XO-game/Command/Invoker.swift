//
//  LogInvoker.swift
//  XO-game
//
//  Created by Evgenii Semenov on 26.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogInvoker {
    
    public static let shared = LogInvoker()
    private init() { }
    
    private let bufferSize = 10
    
    private let markViewPrototype = MarkView()
    var receiver: LogReceiver?
    var commands = [Command]()
    
    
    func addCommand(_ command: Command) {
        guard let logCommand = command as? LogCommand else { return }
        commands.append(logCommand)
        print(commands.count)
        execute()
    }
    
    private func execute() {
        
        guard commands.count >= bufferSize else { return }

        for command in commands {
            switch command.action {
            case .addMark(let player, let position):
                //let userQueue = DispatchQueue.global(qos: .userInitiated)
                //userQueue.sync  {
                    self.receiver?.setPlayer(player, at: position)
                    self.receiver?.addNewMark(self.markViewPrototype, at: position, player: player)
                //}
            }
        }
                
        commands.removeAll()
    }
    
}
