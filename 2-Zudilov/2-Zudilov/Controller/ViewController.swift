//
//  ViewController.swift
//  2-Zudilov
//
//  Created by user179996 on 19.03.2021.
//

import UIKit

class ViewController: UIViewController {

    private let startGameSegueIdentificator = "initGame"
       
    @IBAction func playButton(_ sender: Any) {

    }
    
    @IBOutlet weak var Score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

    }

    override func viewWillAppear(_ animated: Bool) {
        let background = AllFunctions()
        background.setGradientBackground(view: self)
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           case startGameSegueIdentificator:
               guard let destination = segue.destination as? GameController else { return }
               destination.startGameDelegate = self
           default:
               break
           }
    }
}


extension ViewController: ResultGameDelegate {
    func gameResult(result: GameSessioin) {
        print(result)
        Game.shared.addResult(result)
        Game.shared.percentCount(result)
        print(Game.shared.percentCount)
    }
}
