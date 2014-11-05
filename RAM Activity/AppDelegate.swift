//
//  AppDelegate.swift
//  RAM Activity
//
//  Created by Luis Matute on 11/5/14.
//  Copyright (c) 2014 Luis Matute. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var statusMenu: NSMenu!
    
    // Items used as labels
    @IBOutlet weak var freeLabel: NSMenuItem!
    @IBOutlet weak var usedLabel: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let icon = NSImage(named: "menuIcon")
        icon.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        refreshValues()
    }

    @IBAction func refreshAction(sender: AnyObject) {
        refreshValues()
    }

    func refreshValues() -> (used:String, free:String) {
        var response:(used:String, free:String) = (used: "Unknown Used", free: "Unknown Free")

        let buildTask = NSTask()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

        var error:NSError?
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("lookup",ofType: "sh") {
            let lookupTask = NSTask()
            let pipe = NSPipe()
            
            lookupTask.launchPath = path
            lookupTask.standardOutput = pipe
            lookupTask.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = NSString(data: data, encoding: NSUTF8StringEncoding) {
                let tmp = output.componentsSeparatedByString(" ")
                response.used = tmp[0] as String
                response.free = tmp[1] as String
            }
        }
        freeLabel.title = "\(response.free) Free"
        usedLabel.title = "\(response.used) Used"
        // statusItem.title = response.used.stringByReplacingOccurrencesOfString("M", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)

        return response
    }
    
}

