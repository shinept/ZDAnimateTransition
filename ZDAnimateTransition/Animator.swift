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
    private var animatedFrame : CGRect!
    
    var operation : UINavigationControllerOperation!
    
    
    // This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 0.4
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        //获取到要被push的toVC和当前执行push的fromVC
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        //先将将被显示的控制器的view加在上下文里
        transitionContext.containerView().addSubview(toVC!.view)
        
        //计算宽和高应该放大的倍数
        let factoryX : CGFloat = toVC!.view.frame.size.width / fromFrame.size.width;
        let factoryY : CGFloat = toVC!.view.frame.size.height / self.fromFrame.size.height;
        
        //计算出center
        let originalCenter = toVC!.view.center
        let fromCenter = CGPointMake(fromFrame.origin.x + fromFrame.size.width / 2, fromFrame.origin.y + fromFrame.size.height / 2)
        
        //计算center的便宜量，在动画的过程不仅要放大，同时center要便宜到屏幕中心，并且要算入放大系数带来的偏差
        let fromFrameOffsetX = fromCenter.x - originalCenter.x
        let fromFrameOffsetY = fromCenter.y - originalCenter.y
        let fromFrameOffsetCenter = CGPointMake(originalCenter.x - fromFrameOffsetX * factoryX, originalCenter.y - fromFrameOffsetY * factoryY)

        
        var animations = { () -> Void in
        }
        var completion = { (finished:Bool) -> Void in
            
        }
        

        if (operation! == UINavigationControllerOperation.Push) {
            //准备工作
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
                //在这个animator中记录下动画后的animatedFrame,方便在返回的时候从animatedFrame来开始变化
                self.animatedFrame = fromVC!.view.frame;
                //手动设置转场是否完毕，必须写
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            };
            
        }
        else if (operation! == UINavigationControllerOperation.Pop){
            //和push相反的操作
            toVC!.view.frame = animatedFrame;
            
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

