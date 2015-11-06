//
//  AppConfig.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 26/05/15.
//  Copyright (c) 2015 NRC Media. All rights reserved.
//

import Foundation
import UIKit


/**
    Temporary config. Should be moved to a configuration file.
*/
struct AppConfig {
//     API
//     static let baseServerURL = NSURL(string: "http://localhost:5000")! // runserver
//     static let baseServerURL = NSURL(string: "http://localhost:5001")! // demoserver
//     static let baseServerURL = NSURL(string: "http://nsa-unstable.elasticbeanstalk.com")!
//     static let baseServerURL = NSURL(string: "http://nsa-dev.elasticbeanstalk.com")!
    static let baseServerURL = NSURL(string: "http://app-api.nrc.nl")!
    
    static let baseMediaURL = AppConfig.baseServerURL.URLByAppendingPathComponent("__media__")
    static let authURL = AppConfig.baseServerURL.URLByAppendingPathComponent("__auth__")

    static let serverIsFileBased = baseServerURL.URLString.rangeOfString("5001") != nil
    
    static let preloadMediaFormat = MediaFormat.Medium
    
    // AsyncDisplayKit
    static let linkAttributeName = "NSALink"
}