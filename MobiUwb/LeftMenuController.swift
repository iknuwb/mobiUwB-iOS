//
//  LeftMenuController.swift
//  MobiUwb
//
//  Created by jenkins on 20.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

enum LeftMenu:Int {
    case InstInf 
    case WydzFilol
}

protocol LeftMenuProtocol: class {
    func changeViewController(menu: LeftMenu)
}

class LeftMenuController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = [("Instytut Informatyki","uwb"), ("Wydział Filologiczny","uwb")]
    var instInfViewController: UIViewController!
    var wydzFilolViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let instInfViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        self.instInfViewController = UINavigationController(rootViewController: instInfViewController)
        
        let wydzFilolViewController = storyboard.instantiateViewControllerWithIdentifier("WydzFilolViewController") as! WydzFilolViewController
        self.wydzFilolViewController = UINavigationController(rootViewController: wydzFilolViewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorColor = UIColor.grayColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("baseTableViewCell") as! BaseTableViewCell
        
        cell.leftLabel.text = menus[indexPath.row].0
        cell.leftIconImageView.image = UIImage(named: menus[indexPath.row].1)
        return cell
    }
    
    func tableView(TableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .InstInf:
            self.slideMenuController()?.changeMainViewController(self.instInfViewController, close: true)
        case .WydzFilol:
            self.slideMenuController()?.changeMainViewController(self.wydzFilolViewController, close: true)
        }
    }
}

