//
//  AppDelegate.swift
//  ios-nrc-nl
//
//  Created by Niels van Hoorn on 03/02/15.
//

import UIKit
import Fabric
import Crashlytics
import Swinject
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var container: Container = setupDefaultContainer()

    func setupDebuggingTools() {
        Fabric.with([Crashlytics.self()])
        Instabug.configureAndStart()
    }
    
    func setupURLHandling(launchOptions: [NSObject: AnyObject]?) -> Bool {
        var shouldHandleURL: Bool
        if let url = launchOptions?[UIApplicationLaunchOptionsURLKey] as? NSURL {
            let urlHandler = container.resolve(URLHandler.self)!
            shouldHandleURL = !urlHandler.handleOpenURL(url, afterFinishedLaunching: true)
        } else {
            shouldHandleURL = true
        }
        return shouldHandleURL
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        enableBackgroundFetch()
        
        do {
            try Fonts.load()
        } catch {
            print("Error loading fonts:",error)
        }

        let mainViewController = container.resolve(MainViewController.self)

        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
        self.window = window
        
        setupDebuggingTools()
        return setupURLHandling(launchOptions)
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        let urlHandler = container.resolve(URLHandler.self)!
        return urlHandler.handleOpenURL(url, afterFinishedLaunching: false)
    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if let action = userActivity.internalURLAction {
            let urlHandler = container.resolve(URLHandler.self)!
            return urlHandler.handle(action)
        }
        return false
    }

    // MARK:Background Fetch
    func enableBackgroundFetch() {
        UIApplication.sharedApplication().setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        if let fetcher = container.resolve(BackgroundFetcher.self) {
            fetcher.run(completionHandler)
        }
    }
}
