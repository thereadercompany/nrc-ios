//
//  AppConfig.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 26/05/15.
//

import Foundation
import UIKit
import Core

/**
    Temporary config. Should be moved to a configuration file.
*/
struct AppConfig {
    
    // Instabug
    static let instabugKey = "77f996a762dafc1695f83685d8e028b2"
    
    // API
    private static let server = Server.Production
    static var baseServerURL: NSURL {
        set(newValue) {
           NSUserDefaults.standardUserDefaults().setObject(newValue.absoluteString, forKey: AppConfigKey.BaseServerURL.rawValue)
            self.notifyBaseServerURLOverrideIfNeeded("Connected with ")
        }
        get {
            let urlString = NSUserDefaults.standardUserDefaults().objectForKey(AppConfigKey.BaseServerURL.rawValue) as! String
            return NSURL(string: urlString)!
        }
    }
    
    static var baseMediaURL: NSURL {
        get {
            let urlString = NSUserDefaults.standardUserDefaults().objectForKey(AppConfigKey.BaseMediaURL.rawValue) as! String
            return NSURL(string: urlString)!
        }
    }
    
    static var authURL: NSURL {
        get {
            let urlString = NSUserDefaults.standardUserDefaults().objectForKey(AppConfigKey.AuthURL.rawValue) as! String
            return NSURL(string: urlString)!
        }
    }
    
    static let serverIsFileBased = baseServerURL.URLString.rangeOfString("5001") != nil
    static let currentPaywallIdentfierKey = "nl.nrc.timeline.paywall.currentIdentfier"
    
    static let memorySize: UInt = 50000000
    static let cacheSize: UInt = 500000000
    static let cachePeriod: NSTimeInterval = 3.0*4.0*7.0*24.0*60.0*60.0 // 3 months
    static let customScheme = "hbsmb"
    
    static let showTimelineDelay: NSTimeInterval = 1
        
    static func registerDefaults() {
        var defaults:[String : AnyObject] = [:]
        defaults[AppConfigKey.BaseServerURL.rawValue] = server.rawValue+"/__api__";
        defaults[AppConfigKey.BaseMediaURL.rawValue] = server.rawValue+"/__media__";
        defaults[AppConfigKey.AuthURL.rawValue] = server.rawValue+"/__auth__";
        NSUserDefaults.standardUserDefaults().registerDefaults(defaults)
    }
    
    static func resetValue(key: AppConfigKey) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(key.rawValue)
        if case .BaseServerURL = key {
            self.sendNotification(.BaseServerURLReset)
        }
    }
    
    static func notifyBaseServerURLOverrideIfNeeded(prefix:String) {
        if self.baseServerURL.absoluteString != server.rawValue {
            self.sendNotification(.BaseServerURLOverride)
            self.pushBaseServerURLStatusIfNeeded(prefix)
        }
    }
    
    static func pushBaseServerURLStatusIfNeeded(prefix:String) {
        if self.baseServerURL.absoluteString != server.rawValue+"/__api__" {
            StatusManager.sharedInstance.pushStatus(prefix+self.baseServerURL.absoluteString, type: "", replayBlock: nil)
        }
    }
    
    private static func sendNotification(notificationType: AppConfigNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(notificationType.rawValue, object: nil)
        }
    }
}

enum AppConfigKey: String {
    case BaseServerURL = "BaseServerURL"
    case BaseMediaURL = "BaseMediaURL"
    case AuthURL = "AuthURL"
}

enum AppConfigNotification: String {
    case BaseServerURLReset = "io.trc.boeckler.baseserverurl.reset"
    case BaseServerURLOverride = "io.trc.boeckler.baseserverurl.override"
}

enum Server: String {
    case Localhost = "http://localhost:5000"
    case LocalhostDemo = "http://localhost:5001"
    case Production = "http://boeckler-select-api.trc.io"
}

