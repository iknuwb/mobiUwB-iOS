//
//  ViewController.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 18.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//
import Foundation
import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Instytut Informatyki"
        
        let URL = NSURL(string: "http://ii.uwb.edu.pl/mobi/?place=ii&client=android")
        WebView.loadRequest(NSURLRequest(URL: URL!))
        WebView.scrollView.bounces = false;
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

