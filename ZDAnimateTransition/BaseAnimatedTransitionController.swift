//
//  BaseAnimatedTransition.swift
//  ZDInfinity
//
//  Created by 张亚东 on 15/3/26.
//  Copyright (c) 2015年 zhangyd. All rights reserved.
//

import UIKit

class BaseAnimatedTransitionController: UIViewController , UINavigationControllerDelegate{
    
    var interactionController : UIPercentDrivenInteractiveTransition!
    
    var animator = Animator()
    
    lazy var screenEdgePan : UIScreenEdgePanGestureRecognizer = {
        var pan = UIScreenEdgePanGestureRecognizer(target: self, action: "respondsToEdgePan:")
        pan.edges = UIRectEdge.Left
        return pan
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(screenEdgePan)
    }
    
    override func willPopFromNavigationController() {
        navigationController!.delegate = self
    }
    
    func respondsToEdgePan(sender:UIScreenEdgePanGestureRecognizer ) {
        
        if (sender.state == UIGestureRecognizerState.Began) {
            interactionController = UIPercentDrivenInteractiveTransition()
            
            navigationController!.popViewControllerAnimated(true)
        }
            
            
        else if (sender.state == UIGestureRecognizerState.Changed) {
            let translation = sender.translationInView(view.superview!)

            var d = fabs(translation.x / CGRectGetWidth(view.bounds))
            
            d = CGFloat(fminf(fmaxf(Float(d), 0), 1))
            self.interactionController.updateInteractiveTransition(d)
            println(d)
        }
            
            
            
        else if (sender.state == UIGestureRecognizerState.Ended) {
            if (sender.velocityInView(view).x > 0) {
                interactionController.finishInteractiveTransition()
            }
            else {
                interactionController.cancelInteractiveTransition()
            }
            self.interactionController = nil;
        }

    }
    
    //UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        println(self.navigationController!.viewControllers.count)
        
        var correctAnimator : Animator?

        if operation == UINavigationControllerOperation.Push {
            correctAnimator = self.animator
        }
        else if operation == UINavigationControllerOperation.Pop {
            
            correctAnimator = navigationController.viewControllers.last!.animator
        }
        
        correctAnimator!.operation = operation
        return correctAnimator
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
