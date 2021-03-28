//
//  ViewController.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let startGameSegueIdentificator = "initGame"
    private let settingsControlSegue = "settingsControl"
    
    let background = AllFunctions()
    @IBAction func playButton(_ sender: Any) {
    }
    var userAnswersChoiseFromMain = 0
    
    @IBOutlet weak var Score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
       
        if self.view.layer.sublayers?.count == 6 {
           background.setGradientBackground(view: self)
        }
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case startGameSegueIdentificator:
               guard let destination = segue.destination as? GameController else { return }
               destination.startGameDelegate = self
            case settingsControlSegue:
                guard let destination = segue.destination as? SettingsControl else { return }
              
                
           default:
               break
           }
    }
}


extension MainViewController: ResultGameDelegate {
    func gameResult(result: GameSessioin) {
        print(result)
        Game.shared.addResult(result)
        Game.shared.percentCountFunc(result)
        print(Game.shared.percentCount)
    }
}

