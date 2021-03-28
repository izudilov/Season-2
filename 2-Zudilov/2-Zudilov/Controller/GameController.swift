//
//  GameController.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import UIKit

class GameController: UIViewController {
    
    weak var startGameDelegate: ResultGameDelegate!
    let background = AllFunctions()
    var gameStrategy: UserAnswersOrder!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var gameInfo: UILabel!
    
    @IBOutlet var answersButton: [UIButton]!
    var questionsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.usersQuestionsForGame = Game.shared.basicQuestions + Game.shared.addedUserQuestions
        
        print(Game.shared.usersQuestionsForGame)
        
        gameStrategyStrart()
        
       gameInfo.text = """
            Вопросы: 1 из \(Game.shared.questionsForGame.count)
            Процент верных ответов: 0.0
            """
        questionLabel.backgroundColor = UIColor(white: 1, alpha: 0.3)
        questionLabel.text = Game.shared.questionsForGame[0].question
        
        aButton.setTitle(Game.shared.questionsForGame[0].a, for: .normal)
        bButton.setTitle(Game.shared.questionsForGame[0].b, for: .normal)
        cButton.setTitle(Game.shared.questionsForGame[0].c, for: .normal)
        dButton.setTitle(Game.shared.questionsForGame[0].d, for: .normal)
        
        for button in answersButton {
            button.addTarget(self, action: #selector(self.pressed(sender:)) , for: .touchUpInside)
        }

    

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        if self.view.layer.sublayers?.count == 7 {
           background.setGradientBackground(view: self)
        }
        super.viewWillAppear(animated)
    }
    
    @objc func pressed(sender: UIButton!) {
        print(sender.title(for: .normal)!)
        questionsCount += 1

        if sender.title(for: .normal)! == Game.shared.questionsForGame[Game.shared.rightAnswers].rightAnswer && questionsCount < Game.shared.questionsForGame.count {
            Game.shared.rightAnswers += 1
            questionLabel.text = Game.shared.questionsForGame[Game.shared.rightAnswers].question
            aButton.setTitle(Game.shared.questionsForGame[Game.shared.rightAnswers].a, for: .normal)
            bButton.setTitle(Game.shared.questionsForGame[Game.shared.rightAnswers].b, for: .normal)
            cButton.setTitle(Game.shared.questionsForGame[Game.shared.rightAnswers].c, for: .normal)
            dButton.setTitle(Game.shared.questionsForGame[Game.shared.rightAnswers].d, for: .normal)
            let record = GameSessioin(totalCountOfQuestions: Game.shared.questionsForGame.count, countRightAnswers: Game.shared.rightAnswers, date: Date())
            Game.shared.percentCountFunc(record)
            Game.shared.percentCount.addObserver(self, options: [.initial, .new]) {
                [weak self] percent, _ in
                self?.gameInfo.text = """
                    Вопросы: \(self!.questionsCount + 1) из \(Game.shared.questionsForGame.count)
                    Процент верных ответов: \(percent)
                    """
            }
        } else if sender.title(for: .normal)! == Game.shared.questionsForGame[Game.shared.rightAnswers].rightAnswer && questionsCount == Game.shared.questionsForGame.count {
                Game.shared.rightAnswers += 1
            let record = GameSessioin(totalCountOfQuestions: Game.shared.questionsForGame.count, countRightAnswers: Game.shared.rightAnswers, date: Date())
            startGameDelegate.gameResult(result: record)
            //Game.shared.addResult(record)
                background.showMessage(view: self)
            Game.shared.percentCount.addObserver(self, options: [.initial, .new]) {
                [weak self] percent, _ in
                self?.gameInfo.text = """
                    Вопросы: \(self!.questionsCount) из \(Game.shared.questionsForGame.count)
                    Процент верных ответов: \(percent)
                    """
            }
        } else  {
            let record = GameSessioin(totalCountOfQuestions: Game.shared.questionsForGame.count, countRightAnswers: Game.shared.rightAnswers, date: Date())
            startGameDelegate?.gameResult(result: record)
            //Game.shared.addResult(record)
            background.showMessage(view: self)

        }
        
    }
    
    func gameStrategyStrart() {
        switch Game.shared.gameLevel {
        case .inline:
            gameStrategy = InlineQuestions()
            gameStrategy.order(questions: Game.shared.usersQuestionsForGame)
        case .random:
            gameStrategy = RandomQuestionns()
            gameStrategy.order(questions: Game.shared.usersQuestionsForGame)
        }
    }
    
    
    deinit {
        Game.shared.percentCount.removeObserver(self)
    }
}


protocol ResultGameDelegate: class  {
    func gameResult(result: GameSessioin)
}
