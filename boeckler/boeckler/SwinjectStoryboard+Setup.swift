//
//  SwinjectStoryboard+Setup.swift
//  boeckler
//
//  Created by Emiel van der Veen on 24/11/15.
//  Copyright © 2015 TRC. All rights reserved.
//

import Foundation
import Swinject

extension SwinjectStoryboard {
    class func setup() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let container = defaultContainer
        
        container.register(NetworkRequestHandlerType.self) { _  in NetworkRequestHandler()}
        container.register(BlockDecoder.self) { _ in BoecklerBlockDecoder() }
        container.register(SQLiteStore.self) { r in SQLiteStore(decoder: r.resolve(BlockDecoder.self)!) }
        container.register(CacheType.self) { r in SQLiteCache(store: r.resolve(SQLiteStore.self)!) }
        container.register(PaywallStateController.self) { _ in PaywallStateController() }
        container.register(PaywallDataInterceptor.self) { r in PaywallDataInterceptor(paywallController: r.resolve(PaywallStateController.self)!) }
        container.register(BlockContextDataControllerType.self, name: "default-data-controller") { r in BlockContextDataController(cache: r.resolve(CacheType.self)!, networkRequestHandler: r.resolve(NetworkRequestHandlerType.self)!, interceptor: r.resolve(PaywallDataInterceptor.self)! )  }
        container.register(BlockContextDataControllerType.self, name: "paywall-data-controller") { r in BlockContextDataController(cache: r.resolve(CacheType.self)!, networkRequestHandler: r.resolve(NetworkRequestHandlerType.self)!) }
        container.register(TrackerFactoryType.self) { r in TrackerFactory.init(delegate: r.resolve(BlockContextDataControllerType.self)!)}
        container.register(CellFactoryType.self) { r in CellFactory(trackerFactory: r.resolve(TrackerFactoryType.self)!) }
        container.register(VisibilityState.self) { r in VisibilityState(trackerFactory: r.resolve(TrackerFactoryType.self)!) }
        container.register(AuthenticationController.self) { r in AuthenticationController(initialViewController: appDelegate.window!.rootViewController!, paywallController: r.resolve(PaywallStateController.self)! )}
        container.register(URLHandlerType.self) { r in URLHandler(paywallController: r.resolve(PaywallStateController.self)!, authController: r.resolve(AuthenticationController.self)!) }
        
        container.registerForStoryboard(MainViewController.self) { r, c in
            c.dataController = r.resolve(BlockContextDataController.self)
        }
        
        container.registerForStoryboard(TimelineViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandlerType.self)
            c.dataController = r.resolve(BlockContextDataController.self)
            c.cellFactory = r.resolve(CellFactoryType.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataControllerType.self)!)
        }

        container.registerForStoryboard(ArticleViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandlerType.self)
            c.dataController = r.resolve(BlockContextDataController.self, name: "default-data-controller")
            c.cellFactory = r.resolve(CellFactoryType.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataControllerType.self)!)
        }
        
        container.registerForStoryboard(PaywallViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandlerType.self)            
            c.dataController = r.resolve(BlockContextDataController.self, name: "paywall-data-controller")
            c.cellFactory = r.resolve(CellFactoryType.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataControllerType.self)!)
        }
        
        appDelegate.urlHandler = container.resolve(URLHandlerType.self)
    }
}