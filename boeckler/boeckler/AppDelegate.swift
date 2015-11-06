//
//  AppDelegate.swift
//  ios-nrc-nl
//
//  Created by Niels van Hoorn on 03/02/15.
//  Copyright (c) 2015 NRC Media. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var authenticationController: AuthenticationController = {
        //Explicitly unwrappnig window and rootViewController
        return AuthenticationController(initialViewController: self.window!.rootViewController!)
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        do {
            try Fonts.load()
        } catch {
            print("Error loading fonts:",error)
        }
        // Override point for customization after application launch.
        var shouldHandleURL: Bool
        Fabric.with([Crashlytics.self()])
        Instabug.configureAndStart()
        if let url = launchOptions?[UIApplicationLaunchOptionsURLKey] as? NSURL {
            shouldHandleURL = !URLHandler.handleOpenURL(url, afterFinishedLaunching: true, appDelegate: self)
        } else {
            shouldHandleURL = true
        }
        return shouldHandleURL
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        return URLHandler.handleOpenURL(url, afterFinishedLaunching: false, appDelegate: self)
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if let action = userActivity.internalURLAction {
            return URLHandler.handle(action)
        }
        return false
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
