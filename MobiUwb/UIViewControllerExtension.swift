//
//  UIViewControllerExtension.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift


extension UIViewController {
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "LeftMenuIcon")!)
        self.addRightBarButtonWithImage(UIImage(named: "RightMenuIcon")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        let navigation = self.navigationController?.navigationBar
        navigation!.barTintColor = UIColor.init(red: 42/256, green: 42/256, blue: 42/256, alpha: 1)
        navigation!.translucent = false
        navigation!.tintColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigation!.titleTextAttributes = (titleDict as! [String : AnyObject])
//        let verticalConstraint = NSLayoutConstraint(item: navigation!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 10)
//        view.addConstraint(verticalConstraint)
 
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}