//
//  GameSession.swift
//  2-Zudilov
//
//  Created by user179996 on 20.03.2021.
//

import UIKit

struct GameSessioin {
    
    var totalCountOfQuestions: Int
    var countRightAnswers: Int
    var date: Date
}

extension GameSessioin: Codable {}
