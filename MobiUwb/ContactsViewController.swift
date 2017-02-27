//
//  ContactsViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit
import SWXMLHash
import MBProgressHUD
import MessageUI
import MapKit

class ContactsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var fax: UIButton!
    @IBOutlet weak var location: UIButton!
    

    let mobiUrlConfig = "http://ii.uwb.edu.pl/mobi/config.xml"
    var contactInformation:Dictionary<String, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kontakt"
        self.setNavigationBarItem()
      let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.Indeterminate
        DataManager.getDataFrom(mobiUrlConfig) { (MobiUrlData) -> Void in
            if MobiUrlData != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    self.parseXMLContactInformation(MobiUrlData)
                    self.setupViewWithData(self.contactInformation)
                }
            }
        }
    }
    
    
    func parseXMLContactInformation(data:NSData) {
        
        contactInformation = Dictionary<String,String>()
        let xmlData = SWXMLHash.parse(data)
        let xmlContact = try! xmlData["konfiguracja"]["jednostka"].withAttr("xml:id", "e9222687-ea40-5b1a-89ba-c595714d2bbb").children
        for jednostka in xmlContact {
            let nazwa = jednostka.element!.name
            switch nazwa {
            case "email":
                contactInformation["email"] = jednostka.element!.text!
            case "tel1":
                contactInformation["phone"] = jednostka.element!.text!
            case "fax":
                contactInformation["fax"] = jednostka.element!.text!
            case "mapa":
                contactInformation["latitude"] = jednostka["wspolrzedne"]["szerokosc"].element!.text!
                contactInformation["longitude"] = jednostka["wspolrzedne"]["dlugosc"].element!.text!
            case "adres":
                contactInformation["postcode"] = jednostka["kod"].element!.text!
                contactInformation["city"] = jednostka["miasto"].element!.text!
                contactInformation["number"] = jednostka["numer"].element!.text!
                contactInformation["street"] = jednostka["ulica"].element!.text!
            case "nazwa":
                contactInformation["name"] = jednostka.element!.text!
            default:
                break
                
            }
        }
    }
    
    func setupViewWithData(data:Dictionary<String,String>) {
        
        address.text = "\(data["name"]!)\n\(data["postcode"]!) \(data["city"]!)\n\(data["street"]!) \(data["number"]!)"
        phone.setTitle("\(data["phone"]!)", forState: UIControlState.Normal)
        fax.setTitle("\(data["fax"]!)", forState: UIControlState.Normal)
        let emailXML:String = "\(data["email"]!)"
        var properEmail:String = emailXML.stringByReplacingOccurrencesOfString("(kropka)", withString: ".")
        properEmail = properEmail.stringByReplacingOccurrencesOfString("(malpa)", withString: "@")
        email.setTitle(properEmail, forState: UIControlState.Normal)
    }
    
    @IBAction func phoneButtonPressed(sender: UIButton) {
        let xmlPhone:String = (phone.titleLabel?.text)!
        var phoneNumber:String = ""
        for charatacter in xmlPhone.characters {
            switch charatacter {
            case "0","1","2","3","4","5","6","7","8","9":
                phoneNumber = phoneNumber + String(charatacter)
            default:
                print("Removed invalid character")
            }
        }
        
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }

    @IBAction func localizationButtonPressed(sender: UIButton) {
        let lat1 : NSString = self.contactInformation["longitude"]!
        let lng1 : NSString = self.contactInformation["latitude"]!
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 5000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.contactInformation["name"]!)"
        mapItem.openInMapsWithLaunchOptions(options)
    }
    @IBAction func emailButtonPressed(sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mailView = MFMailComposeViewController()
            mailView.mailComposeDelegate = self
            let emails:[String] = [(email.titleLabel?.text)!]
            mailView.setToRecipients(emails)
            presentViewController(mailView, animated: true, completion: nil)
        }
        
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}