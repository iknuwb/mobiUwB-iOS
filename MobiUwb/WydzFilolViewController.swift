//
//  WydzFilolViewController.swift
//  MobiUwb
//
//  Created by jenkins on 20.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import UIKit

class WydzFilolViewController: UIViewController {
    
    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.title = "Wydział Filologiczny"
        
        let URL = NSURL(string: "http://ii.uwb.edu.pl/mobi/?place=wf&client=android")
        WebView.loadRequest(NSURLRequest(URL: URL!))
        WebView.scrollView.bounces = false;
    }
}
