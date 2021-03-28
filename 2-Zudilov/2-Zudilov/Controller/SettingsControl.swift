//
//  Settings.swift
//  2-Zudilov
//
//  Created by user179996 on 24.03.2021.
//

import UIKit

class SettingsControl: UIViewController {
    
    let background = AllFunctions()
    var userChoise = 0
    @IBOutlet var answersSegmentContol: UISegmentedControl!

    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private let settingsControlSegue = "settingsControl"

    override func viewDidLoad() {
        super.viewDidLoad()
        switch Game.shared.gameLevel {
        case .inline:
            answersSegmentContol.selectedSegmentIndex = 0
        case .random:
            answersSegmentContol.selectedSegmentIndex = 1
        }
        answersSegmentContol.addTarget(self, action: #selector(self.userChoiseFunc(sender:)) , for: .valueChanged)
      
    }
    
    @objc func userChoiseFunc(sender: UISegmentedControl) {
        let levelGame = sender.selectedSegmentIndex
        switch levelGame {
        case 0:
            Game.shared.gameLevel = .inline
            print(Game.shared.gameLevel)
        case 1:
            Game.shared.gameLevel = .random
            print(Game.shared.gameLevel)
        default:
            print("Error with game level")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if self.view.layer.sublayers?.count == 3 {
           background.setGradientBackground(view: self)
        }
        super.viewWillAppear(animated)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case settingsControlSegue:
                guard let destination = segue.destination as? MainViewController else { return }
            destination.userAnswersChoiseFromMain = userChoise
                
           default:
               break
           }
    }

}
