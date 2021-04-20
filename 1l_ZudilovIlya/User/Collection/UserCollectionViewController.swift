//
//  UserCollectionViewController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 01.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class UserCollectionViewController: UICollectionViewController, CAAnimationDelegate {

    var image = ""
    var imageArray = [UIImage]()

    let background = UIView()
    var shapeLayer1 = CAShapeLayer()
    var shapeLayer2 = CAShapeLayer()
    var shapeLayer3 = CAShapeLayer()
    
        //let likeButton = LikeButton()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        /*background.backgroundColor = .white
        background.frame = CGRect (x: 0, y: 0, width: view.frame.minX + view.frame.maxX, height: view.frame.maxY)
       
        view.addSubview(background)*/
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
        shapeLayer1.fillColor = VKFlyWeight.grayColor.cgColor
        shapeLayer2.fillColor = VKFlyWeight.grayColor.cgColor
        shapeLayer3.fillColor = VKFlyWeight.grayColor.cgColor
        
        view.layer.addSublayer(shapeLayer1)
        view.layer.addSublayer(shapeLayer2)
        view.layer.addSublayer(shapeLayer3)

        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.beginTime = CACurrentMediaTime()
        animation.fromValue = 0.5
        animation.toValue = 0
        animation.duration = 1
        animation.repeatCount = 2.5
        animation.delegate = self
        
        shapeLayer1.add(animation, forKey: "myLayerAnimation")
        
        animation.beginTime = CACurrentMediaTime() + 0.25
        shapeLayer2.add(animation, forKey: "myLayerAnimation")
        
        animation.beginTime = CACurrentMediaTime() + 0.5
        shapeLayer3.add(animation, forKey: "myLayerAnimation")
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
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFotoCell", for: indexPath) as! UserCollectionViewCell
      
    imageArray = [#imageLiteral(resourceName: "news2"), #imageLiteral(resourceName: "news3"), #imageLiteral(resourceName: "news1") ]
    let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");

    fadeAnim.fromValue = imageArray[0];
    fadeAnim.toValue   = imageArray[1];
    fadeAnim.duration  = 3 ;         //smoothest value

    cell.userFotoCollection.layer.add(fadeAnim, forKey: "contents");

    //cell.userFotoCollection.image = imageArray[1];
     // cell.userFotoCollection.image = UIImage(named: image)
        
        return cell
    }

  
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
