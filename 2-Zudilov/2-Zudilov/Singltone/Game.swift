//
//  Game.swift
//  2-Zudilov
//
//  Created by user179996 on 20.03.2021.
//

import UIKit

class Game {
    static let shared = Game()
    private init () {
        result = caretaker.loadResults()
    }
    private(set) var result: [GameSessioin] = [] {
        didSet {
            caretaker.saveRecords(result)
        }
    }
    private(set) var percentCount: [Double] = []
    private let caretaker = RecordsCaretaker()
        
    func addResult(_ record: GameSessioin) {
        result.append(record)
    }
    
    func percentCount (_ data: GameSessioin) {
        let totalCount = data.totalCountOfQuestions
        let rightAnswers = data.countRightAnswers
        let percent = Double(rightAnswers * 100 / totalCount)
        percentCount.append(percent)
    }
}
