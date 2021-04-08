//
//  Delete.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 17.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class LayerRemover: NSObject, CAAnimationDelegate {
    private weak var layer: CALayer?

    init(for layer: CALayer) {
        self.layer = layer
        super.init()
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        layer?.removeFromSuperlayer()
    }
}
