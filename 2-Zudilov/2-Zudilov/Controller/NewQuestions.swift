//
//  NewQuestions.swift
//  2-Zudilov
//
//  Created by user179996 on 28.03.2021.
//

import UIKit

class NewQuestions: UIViewController {
    
    let background = AllFunctions()

    @IBOutlet var question: UITextField!
    @IBOutlet var aAnswer: UITextField!
    @IBOutlet var bAnswer: UITextField!
    @IBOutlet var cAnswer: UITextField!
    @IBOutlet var dAnswer: UITextField!
    @IBOutlet var aRight: UISwitch!
    @IBOutlet var bRight: UISwitch!
    @IBOutlet var cRight: UISwitch!
    @IBOutlet var dRight: UISwitch!
    
    
    @IBAction func okButton(_ sender: Any) {
       
        var newQuestion = Questions.init(question: "", a: "", b: "", c: "", d: "", rightAnswer: "")
                
        if aRight.isOn {
            newQuestion.rightAnswer = aAnswer.text!
        } else if bRight.isOn {
            newQuestion.rightAnswer = bAnswer.text!
        } else if cRight.isOn {
            newQuestion.rightAnswer = cAnswer.text!
        } else if dRight.isOn {
            newQuestion.rightAnswer = dAnswer.text!
        }
        
        newQuestion.question = question.text!
        newQuestion.a = aAnswer.text!
        newQuestion.b = bAnswer.text!
        newQuestion.c = cAnswer.text!
        newQuestion.d = dAnswer.text!
        
        Game.shared.addQuestions(newQuestion)
        print(Game.shared.addedUserQuestions)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
       
        if self.view.layer.sublayers?.count == 8 {
           background.setGradientBackground(view: self)
        }
        super.viewWillAppear(animated)
    }
    
}
