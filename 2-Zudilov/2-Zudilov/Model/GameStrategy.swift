//
//  GameStrategy.swift
//  2-Zudilov
//
//  Created by user179996 on 28.03.2021.
//

import UIKit

protocol UserAnswersOrder {
    func order (questions: [Questions])
}

class InlineQuestions: UserAnswersOrder {
    func order(questions: [Questions]) {
        Game.shared.rightAnswers = 0
        Game.shared.questionsForGame = questions
    }
}

class RandomQuestionns: UserAnswersOrder {
    func order(questions: [Questions]) {
        if Game.shared.questionsForGame.isEmpty {
            print("Array is Empty")
        } else {
            Game.shared.questionsForGame.removeAll()
            Game.shared.rightAnswers = 0
            print("Removed all elements from Array")
        }
        
        var order = [Int]()

        var i = 0

        while i < Game.shared.usersQuestionsForGame.count {
            let number = Int.random(in: 0..<Game.shared.usersQuestionsForGame.count)
            if order.contains(number) {
                print("Have this number")
            } else {
                order.append(number)
                i += 1
            }
        }
        print(order)
        
        for finalOrder in order {
            Game.shared.questionsForGame.append(Game.shared.usersQuestionsForGame[finalOrder])
        }
    }
    
    
}
