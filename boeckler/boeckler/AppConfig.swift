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
    
    // API
    static let server = Server.LocalhostDemo
    static let baseServerURL = NSURL(string: server.rawValue)!
    static let baseMediaURL = AppConfig.baseServerURL.URLByAppendingPathComponent("__media__")
    static let authURL = AppConfig.baseServerURL.URLByAppendingPathComponent("__auth__")
    
    static let serverIsFileBased = baseServerURL.URLString.rangeOfString("5001") != nil
    static let currentPaywallIdentfierKey = "nl.nrc.timeline.paywall.currentIdentfier"
    static let preloadMediaFormat = MediaFormat.Medium
    
    // AsyncDisplayKit
    static let linkAttributeName = "NSALink"
}

enum Server: String {
    case Localhost = "http://localhost:5000"
    case LocalhostDemo = "http://localhost:5001"
    case OnlineDemo = "http://boeckler-select-api.trc.io"
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

