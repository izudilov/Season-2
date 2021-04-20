//
//  NewsCell.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 15.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    var countNumber = 0
 
    @IBOutlet weak var userFoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var newsData: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsFoto: UIImageView!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var likeNumbers: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBAction func comment(_ sender: Any) {
    }
    @IBAction func share(_ sender: Any) {
    }
    
    @IBAction func clikLike(_ sender: UIButton) {
        
        if like .tag == 0 {
            like.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            like.tintColor = VKFlyWeight.pressedLikeColor
            countNumber += 1
            likeNumbers.text = "\(countNumber)"
            like.tag = 1
        } else   {
            like.setImage(UIImage(systemName: "heart"), for: .normal)
            like.tintColor = .systemBlue
            countNumber -= 1
            likeNumbers.text = "\(countNumber)"
            like.tag = 0
        }
    }
    
    override func layoutSubviews() {
        userFoto.layer.cornerRadius = userFoto.bounds.height / 2
        userFoto.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
