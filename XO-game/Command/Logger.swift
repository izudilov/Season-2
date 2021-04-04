//
//  Logger.swift
//  XO-game
//
//  Created by Evgenii Semenov on 26.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

enum Logger {
    
    static func log(action: LogAction) {
        let command = LogCommand(action: action)
        LogInvoker.shared.addCommand(command)
    }
}
