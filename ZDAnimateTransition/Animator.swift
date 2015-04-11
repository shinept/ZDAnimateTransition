//
//  Animator.swift
//  ZDInfinity
//
//  Created by 张亚东 on 15/3/26.
//  Copyright (c) 2015年 zhangyd. All rights reserved.
//

import UIKit

class Animator: NSObject ,UIViewControllerAnimatedTransitioning{
    
    var fromFrame : CGRect!
    
    var operation : UINavigationControllerOperation!
    private var transformedFrame : CGRect!
    
    // This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 0.4
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        transitionContext.containerView().addSubview(toVC!.view)
        
        //calculator the factory
        let factoryX : CGFloat = toVC!.view.frame.size.width / fromFrame.size.width;
        let factoryY : CGFloat = toVC!.view.frame.size.height / self.fromFrame.size.height;
        
//        let factory : CGFloat = (factoryX + factoryY) / 4
        
        //calculator the centers
        let originalCenter = toVC!.view.center
        let fromCenter = CGPointMake(fromFrame.origin.x + fromFrame.size.width / 2, fromFrame.origin.y + fromFrame.size.height / 2)
        
        let fromFrameOffsetX = fromCenter.x - originalCenter.x
        let fromFrameOffsetY = fromCenter.y - originalCenter.y
        let fromFrameOffsetCenter = CGPointMake(originalCenter.x - fromFrameOffsetX * factoryX, originalCenter.y - fromFrameOffsetY * factoryY)

        
        var animations = { () -> Void in
        }
        var completion = { (finished:Bool) -> Void in
            
        }
        

        if (operation! == UINavigationControllerOperation.Push) {
            //prepare animation
            toVC!.view.transform = CGAffineTransformMakeScale(1/factoryX, 1/factoryY);
            toVC!.view.center = fromCenter;
            toVC!.view.alpha = 0;
            
            animations = { _ -> Void in
                fromVC!.view.transform = CGAffineTransformMakeScale(factoryX, factoryY);
                fromVC!.view.center = fromFrameOffsetCenter;
                fromVC!.view.alpha = 0;
                
                toVC!.view.alpha = 1;
                toVC!.view.transform = CGAffineTransformIdentity;
                toVC!.view.center = originalCenter;
            }
            completion = { _ -> Void in
                self.transformedFrame = fromVC!.view.frame;
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            };
            
        }
        else if (operation! == UINavigationControllerOperation.Pop){
            toVC!.view.frame = transformedFrame;
            
            animations = { _ -> Void in
                fromVC!.view.transform = CGAffineTransformMakeScale(1/factoryX, 1/factoryY);
                fromVC!.view.center = fromCenter;
                fromVC!.view.alpha = 0;
                
                toVC!.view.alpha = 1;
                toVC!.view.transform = CGAffineTransformIdentity;
                toVC!.view.center = originalCenter;
            };
            
            completion = { _ -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
                
            }
        }
        

        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: animations, completion: completion)
    }
}

