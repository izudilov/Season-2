//
//  AnimationController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 17.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class AnimationController: UIViewController, CAAnimationDelegate {

    let background = UIView()
    var shapeLayer1 = CAShapeLayer()
    var shapeLayer2 = CAShapeLayer()
    var shapeLayer3 = CAShapeLayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.backgroundColor = .blue
        background.frame = CGRect (x: 0, y: 0, width: view.frame.minX + view.frame.maxX, height: view.frame.maxY)
       
        view.addSubview(background)
        /*UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        })*/
        
        //2. Радиус уруга
        let circleWidth = CGFloat(13)
        let circleHeight = circleWidth

        //4. Координаты и размеры круга
        let x = view.frame.midX
        let y = view.frame.midY

        let rect1 = CGRect(x: x - 30, y: y, width: circleWidth, height: circleHeight)
        let rect2 = CGRect(x: x , y: y, width: circleWidth, height: circleHeight)
        let rect3 = CGRect(x: x + 30 , y: y, width: circleWidth, height: circleHeight)
        
        let circlePath1 = UIBezierPath(roundedRect: rect1, cornerRadius: circleWidth / 2)
        let circlePath2 = UIBezierPath(roundedRect: rect2, cornerRadius: circleWidth / 2)
        let circlePath3 = UIBezierPath(roundedRect: rect3, cornerRadius: circleWidth / 2)

        shapeLayer1.path = circlePath1.cgPath
        shapeLayer2.path = circlePath2.cgPath
        shapeLayer3.path = circlePath3.cgPath
        
        // Change the fill color
        shapeLayer1.fillColor = UIColor.gray.cgColor
        shapeLayer2.fillColor = UIColor.gray.cgColor
        shapeLayer3.fillColor = UIColor.gray.cgColor
        
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer2)
        view.layer.addSublayer(shapeLayer3)

        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.beginTime = CACurrentMediaTime()
        animation.fromValue = 0.5
        animation.toValue = 0
        animation.duration = 1
        animation.repeatCount = 3
        animation.delegate = self
        
        shapeLayer1.add(animation, forKey: "myLayerAnimation")
        
        animation.beginTime = CACurrentMediaTime() + 0.25
        shapeLayer2.add(animation, forKey: "myLayerAnimation")
        
        animation.beginTime = CACurrentMediaTime() + 0.5
        shapeLayer3.add(animation, forKey: "myLayerAnimation")
        
        loadingAnimation()
        

    }
    
    
    func loadingAnimation() {
        

       
        
        //animation.delegate = LayerRemover(for: shapeLayer1)
        

    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag == true {
            background.removeFromSuperview()
            shapeLayer1.removeFromSuperlayer()
            shapeLayer2.removeFromSuperlayer()
            shapeLayer3.removeFromSuperlayer()
            /*circlePath1.removeAllPoints()
            circlePath2.removeAllPoints()
            circlePath3.removeAllPoints()*/
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
}
