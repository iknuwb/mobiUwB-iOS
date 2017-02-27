//
//  Announcement.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.05.2016.
//  Copyright © 2016 Grzegorz Szymański. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class AnnouncementManager {
    
    static let sharedInstance = AnnouncementManager()
    
    
   private init() {

    }
    
    func newAnnouncementsInCategory(category:String) {
        
        
        dateOfLastAnnouncementsOfCategory(category) { completion in
            if let lastAnnouncementDate = self.parseAnnouncementDate(completion) {
                var lastCheck:NSDate
                if let lastCheckedDate:NSDate = self.userDefaults.objectForKey("lastCheck") as? NSDate {
                    lastCheck = lastCheckedDate
                } else {
                    lastCheck = NSDate()
                }
                let compare = lastAnnouncementDate.compare(lastCheck)
                if compare == .OrderedDescending {
                    self.sendNotificationForCategory(category)
                }
                lastCheck = NSDate()
                self.userDefaults.setObject(lastCheck, forKey: "lastCheck")
            }
            
            
        }
        
    }
    
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    func startMonitoring() {
        
           let frequency = userDefaults.doubleForKey("czestotliwosc")
        if frequency != 0 {
        NSTimer.scheduledTimerWithTimeInterval(frequency, target: self, selector: #selector(AnnouncementManager.checkCategory), userInfo: nil, repeats: true)
            }
    }

    @objc func checkCategory() {
        
        
        if userDefaults.boolForKey("aktualnosci") {
            self.newAnnouncementsInCategory("io")
        }
        if userDefaults.boolForKey("zajecia") {
            self.newAnnouncementsInCategory("sz")
        }
        if userDefaults.boolForKey("sprawy") {
            self.newAnnouncementsInCategory("so")
        }
        if userDefaults.boolForKey("biuro") {
            self.newAnnouncementsInCategory("bk")
        }
        if userDefaults.boolForKey("szkolenia") {
            self.newAnnouncementsInCategory("sk")
        }
        
    }


    func sendNotificationForCategory(category:String) {
        let notification:UILocalNotification = UILocalNotification()
        switch category {
        case "io":
            notification.alertBody = "Nowe informacje w Aktualnościach"
        case "sz":
            notification.alertBody = "Nowe zajęcia odwołane"
        case "so":
            notification.alertBody = "Nowe informache w Sprawy ogólne"
        case "bk":
            notification.alertBody = "Nowe ogłoszenia w Biuro karier"
        case "sk":
            notification.alertBody = "Nowe szkolenia i praktyki"
        case "plan":
            notification.alertBody = "Nowy plan"
        default:
            notification.alertBody = ""
        }
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    func dateOfLastAnnouncementsOfCategory(category:String,completion:(String?)->Void){
        
        let categoryURL = "http://ii.uwb.edu.pl/serwis/?/json/"+category
        
        Alamofire.request(.GET, categoryURL).responseJSON { response in
            var lastAnnouncement:String?
            var parsedJsonData = [MobiUwbModel]()
            let json = JSON(response.result.value!)
            if let unparsedJsonData = json.array {
                
                
                for dataJson in unparsedJsonData {
                    
                    let daneData: String? = dataJson["data"].string
                    let daneTresc: String? = dataJson["tresc"].string
                    let daneTytul: String? = dataJson["tytul"].string
                    
                    let oneData = MobiUwbModel(data: daneData, tresc: daneTresc, tytul: daneTytul)
                    parsedJsonData.append(oneData)
                }
                
            }
            lastAnnouncement = parsedJsonData[0].data
            completion(lastAnnouncement)

            }
    }
    
    func parseAnnouncementDate(date: String?) -> NSDate? {
        
        if let newDate = date {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        
        let parsedDate = dateFormatter.dateFromString(newDate)
            return parsedDate
        } else {
            return nil
        }
        
    }
}