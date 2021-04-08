//
//  LikeButton.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 08.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class LikeButton: UIControl {

    enum LikeStatus {
        case like
        case dislike
    }
    
    var likeImage = UIImageView(image: UIImage(named: "like"))

    var likeState = LikeStatus.dislike {
        didSet {
            self.updateLikeState(self.likeState)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.likeImage)
        
        self.likeImage.translatesAutoresizingMaskIntoConstraints = false
        let constraintY = self.likeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let constraintX = self.likeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let width = self.likeImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        let height = self.likeImage.heightAnchor.constraint(equalTo: self.heightAnchor
        )
        
        constraintX.isActive = true
        constraintY.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.updateLikeState(self.likeState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLikeState (_ state: LikeStatus) {
        switch state {
        case .like:
            likeImage = UIImageView(image: UIImage(named: "heart"))
        case .dislike:
            likeImage = UIImageView(image: UIImage(named: "like"))
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    
}
