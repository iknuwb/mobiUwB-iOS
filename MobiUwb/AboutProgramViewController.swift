//
//  AboutProgramViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SWXMLHash



enum AboutSection {
    case Supervisor
    case Authors
    case License
    case Thanks
}

class AboutProgramViewController: UITableViewController {
    
    let MobiUrlConfig = "http://ii.uwb.edu.pl/mobi/config.xml"
    var authors = [String]()
    var supervisor:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.getDataFrom(MobiUrlConfig) { (MobiUrlData) -> Void in
        let xml = SWXMLHash.parse(MobiUrlData)
            self.supervisor=xml["konfiguracja"]["opiekunowie"]["opiekun"].element!.text!
            for author in 0 ..< xml["konfiguracja"]["autorzy"]["autor"].all.count {
              self.authors.append(xml["konfiguracja"]["autorzy"]["autor"][author].element!.text!)
            }
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.tableView.reloadData()
            }
        }
        tableView.backgroundColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1)
        
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }


    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        
        if section == 1 {
            rowCount = authors.count
        } else  {
            rowCount = 1
        }
        return rowCount
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HeaderTableViewCell
        switch section {
        case AboutSection.Supervisor.hashValue :
            headerCell.headerTitle.text = "Opiekun"
        case AboutSection.Authors.hashValue :
            headerCell.headerTitle.text = "Autorzy"
        case AboutSection.License.hashValue :
            headerCell.headerTitle.text = "Licencja"
        case AboutSection.Thanks.hashValue :
            headerCell.headerTitle.text = "Podziękowania"
        default:
            headerCell.headerTitle.text = "hahash"
        }
        headerCell.backgroundColor = UIColor.init(red: 31/255.0, green: 31/255.0, blue: 31/255.0, alpha: 1)
        return headerCell
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: BaseTableViewCell = tableView.dequeueReusableCellWithIdentifier("authorsCell") as! BaseTableViewCell
        
        switch indexPath.section {
            
        case AboutSection.Supervisor.hashValue:
            
            cell.aboutLabel.text = supervisor
            cell.aboutIcon.image = UIImage(named: "SupervisorW")
        
        case AboutSection.Authors.hashValue:
            
            cell.aboutLabel.text = authors[indexPath.row]
            cell.aboutIcon.image = UIImage(named: "AuthorW")
        
        case AboutSection.License.hashValue:
            
            cell.aboutLabel.text = "Program na licencji MIT"
            cell.aboutIcon.image = UIImage(named: "MiTW")
        
        case AboutSection.Thanks.hashValue:
            
            cell.aboutLabel.text = "Autorzy pragną podziękować wszystkim członkom Informatycznego Koła Naukowego UwB oraz dyrekcji Instytutu Informatyki"
            cell.aboutIcon.image = UIImage(named: "ThxW")
        default:
            
            cell.aboutLabel.text = ""
        }
         return cell
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "O programie"
    }
    
}