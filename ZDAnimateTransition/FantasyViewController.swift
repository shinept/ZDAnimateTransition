//
//  SecondDetailViewController.swift
//  AmazingAnimateTransition
//
//  Created by 张亚东 on 15/4/11.
//  Copyright (c) 2015年 blurryssky. All rights reserved.
//

import UIKit

class FantasyViewController: BaseAnimatedTransitionController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as ShineptViewController
        destinationVC.view.backgroundColor = sender?.titleColorForState(UIControlState.Normal)
        destinationVC.view.alpha = 0.5
        
        self.animator.fromFrame = sender!.frame
        navigationController!.delegate = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
