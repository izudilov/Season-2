//
//  GameController.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import UIKit

class GameController: UIViewController {
    
    weak var startGameDelegate: ResultGameDelegate!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    var questionsCount = 0
    var rightAnswers = 0
    
    var questionsForGame = [
        Questions(question: "Откуда сотрудники офисов наливают в чашки воду?", a: "A: из принтера", b: "B: из сканера", c: "C: из степлера", d: "D: из кулера", rightAnswer: "D: из кулера"),
        Questions(question: "Что построил Джек в стихотворении, переведенным с английского Маршаком?", a: "A: маршрут", b: "B: график", c: "C: дом", d: "D: коммунизм", rightAnswer: "C: дом"),
        Questions(question: "Что может возникнуть на шахматной доске?", a: "A: вечный шах", b: "B: вечный мат", c: "C: вечный зов", d: "D: вечный двигатель", rightAnswer: "A: вечный шах"),
        Questions(question: "Что такое каршеринг?", a: "A: секонд-хенд", b: "B: напольный светильник", c: "C: брачный танец вороны", d: "D: аренда автомобиля", rightAnswer: "D: аренда автомобиля"),
        Questions(question: "Какие мужчины, согласно этикету, не обязаны идти слева от дамы?", a: "A: высокие", b: "B: пожилые", c: "C: иногородние", d: "D: военнослужащие", rightAnswer: "D: военнослужащие"),
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        questionLabel.backgroundColor = UIColor(white: 1, alpha: 0.3)
        questionLabel.text = questionsForGame[0].question
        aButton.setTitle(questionsForGame[0].a, for: .normal)
        bButton.setTitle(questionsForGame[0].b, for: .normal)
        cButton.setTitle(questionsForGame[0].c, for: .normal)
        dButton.setTitle(questionsForGame[0].d, for: .normal)
        aButton.addTarget(self, action: #selector(self.pressed(sender:)) , for: .touchUpInside)
        bButton.addTarget(self, action: #selector(self.pressed(sender:)) , for: .touchUpInside)
        cButton.addTarget(self, action: #selector(self.pressed(sender:)) , for: .touchUpInside)
        dButton.addTarget(self, action: #selector(self.pressed(sender:)) , for: .touchUpInside)
    

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let background = AllFunctions()
        background.setGradientBackground(view: self)
        super.viewWillAppear(animated)
    }
    
    @objc func pressed(sender: UIButton!) {
        print(sender.title(for: .normal)!)
        questionsCount += 1

        if sender.title(for: .normal)! == questionsForGame[rightAnswers].rightAnswer && questionsCount < questionsForGame.count {
            rightAnswers += 1
            questionLabel.text = questionsForGame[rightAnswers].question
            aButton.setTitle(questionsForGame[rightAnswers].a, for: .normal)
            bButton.setTitle(questionsForGame[rightAnswers].b, for: .normal)
            cButton.setTitle(questionsForGame[rightAnswers].c, for: .normal)
            dButton.setTitle(questionsForGame[rightAnswers].d, for: .normal)
        } else if sender.title(for: .normal)! == questionsForGame[rightAnswers].rightAnswer && questionsCount == questionsForGame.count {
            rightAnswers += 1
            let record = GameSessioin(totalCountOfQuestions: questionsForGame.count, countRightAnswers: rightAnswers, date: Date())
            startGameDelegate.gameResult(result: record)
            //Game.shared.addResult(record)
            self.dismiss(animated: true, completion: nil)
        } else  {
            let record = GameSessioin(totalCountOfQuestions: questionsForGame.count, countRightAnswers: rightAnswers, date: Date())
            startGameDelegate?.gameResult(result: record)
            //Game.shared.addResult(record)
            self.dismiss(animated: true, completion: nil)
        }
        
    }

}

protocol ResultGameDelegate: class  {
    func gameResult(result: GameSessioin)
}
