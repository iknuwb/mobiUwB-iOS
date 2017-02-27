//
//  RightMenuController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

enum RightMenu:Int {
    
    case Home = 0
    case Contacts
    case AboutProgram
    case Settings
}

protocol RightMenuProtocol: class {
    func changeViewController(menu: RightMenu)
}

class RightMenuController: UIViewController, RightMenuProtocol {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var menus = [("Ekran główny","Home-100"),("Kontakt","ContactIcon3"),("O programie","AboutProgramIcon2"),("Ustawienia", "settings")]
    var mainViewController: UIViewController!
    var contactsViewController: UIViewController!
    var aboutProgramViewController: UIViewController!
    var settingsViewController:UIViewController!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
   
        let contactsViewController = storyboard.instantiateViewControllerWithIdentifier("ContactsViewController") as! ContactsViewController
        self.contactsViewController = UINavigationController(rootViewController: contactsViewController)
        
        let aboutProgramViewController = storyboard.instantiateViewControllerWithIdentifier("AboutProgramViewController") as! AboutProgramViewController
        self.aboutProgramViewController = UINavigationController(rootViewController: aboutProgramViewController)
        
        let settingsViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        self.settingsViewController = UINavigationController(rootViewController: settingsViewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("baseTableViewCell") as! BaseTableViewCell
        
        cell.label.text = menus[indexPath.row].0
        cell.iconImageView.image = UIImage(named: menus[indexPath.row].1)
        cell.iconImageView.image = cell.iconImageView.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cell.iconImageView.tintColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.blackColor()

        return cell
    }

    func tableView(TableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = RightMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    func changeViewController(menu: RightMenu) {
        switch menu {
        case .Home:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Contacts:
            self.slideMenuController()?.changeMainViewController(self.contactsViewController, close: true)
        case .AboutProgram:
            self.slideMenuController()?.changeMainViewController(self.aboutProgramViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self.settingsViewController, close: true)
        }
    }
    
}
