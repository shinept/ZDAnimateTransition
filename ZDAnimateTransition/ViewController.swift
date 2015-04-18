//
//  ViewController.swift
//  AmazingAnimateTransition
//
//  Created by 张亚东 on 15/4/11.
//  Copyright (c) 2015年 blurryssky. All rights reserved.
//

import UIKit

let ZDScreenWidth = UIScreen.mainScreen().bounds.width
let ZDScreenHeight = UIScreen.mainScreen().bounds.height


class ViewController: BaseAnimatedTransitionController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let senderWidth : CGFloat = 40
        self.animator.fromFrame = CGRectMake(ZDScreenWidth - senderWidth, 20, senderWidth, 40)
        navigationController!.delegate = self
    }

}

