//
//  DetailViewController.swift
//  AmazingAnimateTransition
//
//  Created by 张亚东 on 15/4/11.
//  Copyright (c) 2015年 blurryssky. All rights reserved.
//

import UIKit

class DetailViewController: BaseAnimatedTransitionController ,UITableViewDataSource,UITableViewDelegate{
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! FantasyViewController
        destinationVC.view.backgroundColor = sender?.backgroundColor
        
        self.animator.fromFrame = sender!.frame
        navigationController!.delegate = self
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let randomRed = CGFloat(arc4random() % 120) + 135
        let randomGreen = CGFloat(arc4random() % 120) + 135
        let randomBlue = CGFloat(arc4random() % 120) + 135
        
        cell.backgroundColor = UIColor(red: randomRed / 255, green: randomGreen / 255, blue: randomBlue/255, alpha: 1)
        
        return cell
    }
    
    
}
