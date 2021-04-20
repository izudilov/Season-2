//
//  CustomControler.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 25.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false

}

class CustomNavigationController: UINavigationController {

    let interactiveTransition = CustomInteractiveTransition()
    private let animator = RotationOverTransitioningAnimator()


    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        transitioningDelegate = self

        let edgePanGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        edgePanGR.edges = .left
        view.addGestureRecognizer(edgePanGR)
  
    }
    
    
    @objc
    func handleGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
       
        switch recognizer.state {
        case .began:
            print("Began")
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
            
        case .changed:
            guard let width = recognizer.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x / width
            let progress = max(0, min(1, relativeTranslation))
            
            interactiveTransition.update(progress)
            print(progress > 0.33)
            interactiveTransition.shouldFinish = progress > 0.33
            
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()

        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
      
        default:
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return RotationOverTransitioningAnimator()
        case .pop:
            return RotationOffTransitioningAnimator()
        default:
            return nil
        }
    }
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

