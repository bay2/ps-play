//
//  ViewController.swift
//  ps-play
//
//  Created by xuemincai on 16/5/24.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit

let kNameOfService = "_photoshopserver._tcp."
let kUserDefinedService = "Use IP Address"

class ViewController: UIViewController, NSNetServiceBrowserDelegate {
    
    let serviceBrowser = NSNetServiceBrowser()
    
    var serviceList: [NSNetService] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        serviceBrowser.delegate = self
        
        serviceBrowser.searchForServicesOfType(kNameOfService, inDomain: "")
        
//        serviceList.append(NSNetService(domain: "", type: kNameOfService, name: kUserDefinedService, port: 49494))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didFindService service: NSNetService, moreComing: Bool) {
        
        print("\(service)")
        
    }
    
    func netServiceBrowserWillSearch(browser: NSNetServiceBrowser) {
        
        print("netServiceBrowserWillSearch")
        
    }
    
    func netServiceBrowserDidStopSearch(browser: NSNetServiceBrowser) {
        
        print("netServiceBrowserDidStopSearch")
        
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        
        print("didNotSearch")
        
    }
    
    func netServiceBrowser(browser: NSNetServiceBrowser, didRemoveService service: NSNetService, moreComing: Bool) {
        
        print("didRemoveService")
        
    }


}

