//
//  StartViewController.swift
//  XO-game
//
//  Created by user179996 on 31.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var playerVSplayer: UIButton!
    @IBOutlet var playerVScomputer: UIButton!
    
    let playerVSplayerSeque = "playerVSplayer"
    let playerVScomputerSeque = "playerVScomputer"
    let extraMode = "extraMode"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           switch segue.identifier {
           
            case playerVScomputerSeque:
                guard let destination = segue.destination as? GameViewController else { return }
                destination.userVSuser = false
           case extraMode:
               guard let destination = segue.destination as? GameViewController else { return }
               destination.newMode = true
                
           default:
               break
           }
    }

}
