//
//  AppDelegate.swift
//  SharingBrowser
//
//  Created by Peter Wood on 20.08.14.
//
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, NSTableViewDataSource {
                            
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var sharedPointsTable: NSTableView!
    @IBOutlet weak var afpCheckBox: NSButton!
    @IBOutlet weak var smbCheckBox: NSButton!
    @IBOutlet weak var searchBtn: NSButton!
    
    let sharedBrowser = SharedBrowser()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        sharedPointsTable.target = self
        sharedPointsTable.doubleAction = "mountToShare:"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadSharedPointsTable", name: "NewSharedDetected", object: sharedBrowser)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sharedBrowser.sharedPointsList.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if row < 0 || row >= sharedBrowser.sharedPointsList.count {
            return ""
        }
        if let columnId = tableColumn?.identifier {
            let sharedPoint = sharedBrowser.sharedPointsList[row]
            if columnId == "name" {
                return sharedPoint.netService.name
            } else if columnId == "domain" {
                return sharedPoint.netService.domain
            } else if columnId == "type" {
                return sharedPoint.type
            } else if columnId == "ip" {
                return sharedPoint.ipAddress
            }
        }
        return ""
    }
    
    func mountToShare(sender:NSTableView!) {
        var clickedRow = sender.clickedRow
        if (clickedRow < 0) || (clickedRow > (sharedBrowser.sharedPointsList.count - 1))  {
            return
        }
        
        let sharedPoint = sharedBrowser.sharedPointsList[clickedRow]
        let ip = sharedPoint.ipAddress
        NSLog("tell application \"Finder\"\ntry\nmount volume \"\(sharedPoint.type)://\(ip)\"\nend try\nend tell")
        if let a = NSAppleScript(source:"tell application \"Finder\"\ntry\nmount volume \"\(sharedPoint.type)://\(ip)\"\nend try\nend tell\n") {
            var errorInfo: NSDictionary?
            if a.compileAndReturnError(&errorInfo) {
                if (a.executeAndReturnError(&errorInfo) != nil) {
                    // success
                }
            } else {
            }
            if errorInfo != nil {
                NSLog("Error: %@", errorInfo!);
            }
        }
    }
    
    func reloadSharedPointsTable() {
        sharedPointsTable.reloadData()
    }

    @IBAction func searchBtnAction(sender: AnyObject) {
        var searchType:ServiceType?
        if afpCheckBox.state == NSOnState {
            if smbCheckBox.state == NSOnState {
                searchType = .AfpAndSmb
            } else {
                searchType = .Afp
            }
        } else if smbCheckBox.state == NSOnState {
            searchType = .Smb
        }
        
        if searchType != nil {
            sharedBrowser.reset()
            sharedPointsTable.reloadData()
            sharedBrowser.searchForServicesOfType(searchType!);
        } else {
            let alert = NSAlert()
            alert.messageText = "Choose protocol!"
            alert.alertStyle = .WarningAlertStyle
            alert.runModal()
        }
    }
}

