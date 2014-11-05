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
    
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()
    
    // let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let icon = NSImage(named: "menuIcon")
        icon.setTemplate(true)
        
        // statusItem.image = icon
        // statusItem.menu = statusMenu
        // Add statusBarItem
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        statusBarItem.title = "Memory"
        
        // Add menuItem to menu
        menuItem.title = "Used"
        menuItem.action = Selector("setWindowVisible:")
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
        
        // Create a scheduled timer to run `refreshValues` every 2 seconds
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("refreshValues"), userInfo: nil, repeats: true)
    }

    func refreshValues() {
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
        println(1)
        statusBarItem.title = "\(response.used) Used"
    }
 
    func setWindowVisible(sender: AnyObject){
        self.window!.orderFront(self)
    }
}

