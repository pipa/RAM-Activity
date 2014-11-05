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
    var menu: NSMenu = NSMenu(title: "Memory")
    var menuUsedItem : NSMenuItem = NSMenuItem(title: "Used", action: Selector("setWindowVisible:"), keyEquivalent: "")
    var menuFreeItem : NSMenuItem = NSMenuItem(title: "Free", action: Selector("setWindowVisible:"), keyEquivalent: "")
    var menuExitItem: NSMenuItem = NSMenuItem(title: "Quit", action: Selector("exitNow"), keyEquivalent: "")
    
    // let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-2)

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Add statusBarItem
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu

        // Add Menu Items
        menu.addItem(menuUsedItem)
        menu.addItem(menuFreeItem)
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(menuExitItem)
        
        // Create a scheduled timer to run `refreshValues` every 2 seconds
        var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("refreshValues"), userInfo: nil, repeats: true)
    }

    func refreshValues() {
        var response:(used:String, free:String) = (used: "Unknown Used", free: "Unknown Free")

        let buildTask = NSTask()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

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
        
        let usedInGb = NSString(format: "%.2f", NSString(string: response.used).doubleValue / 1024 )
        let freeInGb = NSString(format: "%.2f", NSString(string: response.free).doubleValue / 1024 )
        statusBarItem.title = "\(usedInGb)GB Used"
        menuUsedItem.title = "\(usedInGb)GB Used"
        menuFreeItem.title = "\(freeInGb)GB Free"
    }
 
    func setWindowVisible(sender: AnyObject){
        self.window!.orderFront(self)
    }
    
    func exitNow() {
        NSApplication.sharedApplication().terminate(self)
    }
}

