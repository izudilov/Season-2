//
//  NewViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 25.10.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    
    
    @IBOutlet weak var gif: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    let image = [UIImage(named: "404.gif")!]
    gif.animationImages = image
    gif.animationDuration = 100
    gif.startAnimating()
    
    }
    

    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
