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
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let icon = NSImage(named: "menuIcon")
        icon.setTemplate(true)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        refreshValues()
    }

    @IBAction func refreshAction(sender: AnyObject) {
    }

    func refreshValues() -> (String,String) {
//        let topTask = NSTask(),
//            grepTask = NSTask()
//        
//        topTask.launchPath = "/usr/bin/top"
//        grepTask.launchPath = "/usr/bin/grep"
//        
//        topTask.arguments = ["-l","1"]
//        
//        topTask.launch()
//        topTask.waitUntilExit()
//        
//        grepTask.arguments = ["-i","PhysMem:",topTask.value()]
//        grepTask.launch()
//        grepTask.waitUntilExit()
//        println(grepTask)

        let buildTask = NSTask()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
//        let path = dir.stringByAppendingPathComponent("MemLookup.sh")
        var error:NSError?
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("AppDelegate",ofType: "swift") {
            myDict = NSDictionary(contentsOfFile: path)
            println(path)
        }
        return ("Used", "Free")
    }
    
}

