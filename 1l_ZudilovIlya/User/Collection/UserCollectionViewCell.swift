//
//  UserCollectionViewCell.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 01.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    var countNumber = 0
    
    @IBOutlet weak var userFotoCollection: UIImageView!
    
    @IBOutlet weak var count: UILabel!
    
    @IBOutlet weak var buttonLike: UIButton!
    
    @IBAction func clikLike(_ sender: UIButton) {
        
        if buttonLike .tag == 0 {
            buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonLike.tintColor = .red
            countNumber += 1
            count.text = "\(countNumber)"
            buttonLike.tag = 1
            count.alpha = 0.2
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [],
                           animations:{
                            self.count.alpha = 1
                            self.count.frame.origin.x -= 10
                           })
            
        } else   {
            buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
            buttonLike.tintColor = .systemBlue
            countNumber -= 1
            count.text = "\(countNumber)"
            buttonLike.tag = 0
            count.alpha = 0.2
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [],
                           animations:{
                            self.count.alpha = 1
                            self.count.frame.origin.x -= 10
                           })        }
    }
}
