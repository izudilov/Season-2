//
//  NoMyGtoupViewCell.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 03.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class NoMyGtoupViewCell: UITableViewCell {


    
    @IBOutlet weak var noMyGroupLogo: UIImageView!
    
    @IBOutlet weak var noMyGroupName: UILabel!
    

    override func layoutSubviews() {
        noMyGroupLogo.layer.cornerRadius = noMyGroupLogo.bounds.height / 2
        noMyGroupLogo.clipsToBounds = true
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

