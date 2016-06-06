//
//  AppConfig.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 26/05/15.
//

import Foundation
import UIKit

/**
    Temporary config. Should be moved to a configuration file.
*/
struct AppConfig {
    
    // Instabug
    static let instabugKey = "96eff9b30e3192f192f24f927ba6de2f"
    
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
    static let preloadMediaFormat = MediaFormat.Medium
    static let maxMediaFormat = MediaFormat.Large
    
    static let memorySize: UInt = 50000000
    static let cacheSize: UInt = 500000000
    static let cachePeriod: NSTimeInterval = 3.0*4.0*7.0*24.0*60.0*60.0 // 3 months
    static let customScheme = "hbsmb"
    
    
    // AsyncDisplayKit
    static let linkAttributeName = "NSALink"
    
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
            StatusManager.sharedInstance.pushStatusMessage(prefix+self.baseServerURL.absoluteString, type: "", displayTime: 3, replayBlock: nil)
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

enum BlockContext: String, Equatable {
    case Timeline = "timelines"
    case Article = "articles"
    case Paywall = "paywalls"
    case Unknown = "unknown"
}

enum AuthenticationNotification: String {
    case Started = "io.trc.boeckler.authentication.started"
    case LoginCancelled = "io.trc.boeckler.authentication.cancelled"
    case LoginFailed = "io.trc.boeckler.authentication.failed"
    case LoginSucceeded = "io.trc.boeckler.authentication.succeeded"
    case Finished = "io.trc.boeckler.authentication.finished"
    case Revoked = "io.trc.boeckler.authentication.revoked"
}