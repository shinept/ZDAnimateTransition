//
//  ZDNavigationController.swift
//  ZDInfinity
//
//  Created by 张亚东 on 15/3/27.
//  Copyright (c) 2015年 zhangyd. All rights reserved.
//

import UIKit

extension UIViewController {
    func willPopFromNavigationController() ->Void {
        
    }
}

class ZDNavigationController: UINavigationController {
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        
        let vc = self.topViewController
        
        vc.willPopFromNavigationController()
        
        return super.popViewControllerAnimated(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
