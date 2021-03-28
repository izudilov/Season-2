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
        addedUserQuestions = caretaker.loadQuestions()
    }
    private(set) var result: [GameSessioin] = [] {
        didSet {
            caretaker.saveRecords(result)
        }
    }
    private(set) var percentCount = CustomObservable<Double>(0.0)
    var gameLevel: AnswersOrder = .inline
    private let caretaker = RecordsCaretaker()
    var basicQuestions =  [
        Questions(question: "Откуда сотрудники офисов наливают в чашки воду?", a: "A: из принтера", b: "B: из сканера", c: "C: из степлера", d: "D: из кулера", rightAnswer: "D: из кулера"),
        Questions(question: "Что построил Джек в стихотворении, переведенным с английского Маршаком?", a: "A: маршрут", b: "B: график", c: "C: дом", d: "D: коммунизм", rightAnswer: "C: дом"),
        Questions(question: "Что может возникнуть на шахматной доске?", a: "A: вечный шах", b: "B: вечный мат", c: "C: вечный зов", d: "D: вечный двигатель", rightAnswer: "A: вечный шах"),
        Questions(question: "Что такое каршеринг?", a: "A: секонд-хенд", b: "B: напольный светильник", c: "C: брачный танец вороны", d: "D: аренда автомобиля", rightAnswer: "D: аренда автомобиля"),
        Questions(question: "Какие мужчины, согласно этикету, не обязаны идти слева от дамы?", a: "A: высокие", b: "B: пожилые", c: "C: иногородние", d: "D: военнослужащие", rightAnswer: "D: военнослужащие"),
    ]
    
    var usersQuestionsForGame: [Questions] = [] 
    
    private(set) var addedUserQuestions: [Questions] = [] {
        didSet {
            caretaker.saveQuestions(addedUserQuestions)
        }
    }
    var questionsForGame = [Questions]()
    
    var rightAnswers = 0
    
    func addResult(_ record: GameSessioin) {
        result.append(record)
    }
    
    func addQuestions(_ record: Questions) {
        addedUserQuestions.append(record)
    }
    
    func percentCountFunc (_ data: GameSessioin) {
        let totalCount = data.totalCountOfQuestions
        let rightAnswers = data.countRightAnswers
        let percent = Double(rightAnswers * 100 / totalCount)
        percentCount.value = percent
    }
}
