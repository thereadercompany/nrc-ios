//
//  SwinjectStoryboard+Setup.swift
//  boeckler
//
//  Created by Emiel van der Veen on 24/11/15.
//

import Foundation
import Swinject

extension SwinjectStoryboard {
    class func setup() {
        
        let container = defaultContainer
        
        container.register(NetworkRequestHandler.self) { _  in CoreNetworkRequestHandler()}
        container.register(BlockDecoder.self) { _ in BoecklerBlockDecoder() }
        container.register(Store.self) { r in SQLiteStore(decoder: r.resolve(BlockDecoder.self)!) }
        container.register(Cache.self) { r in CoreCache(store: r.resolve(Store.self)!) }
        container.register(PaywallStateController.self) { _ in CorePaywallStateController() }
        container.register(PaywallDataInterceptor.self) { r in CorePaywallDataInterceptor(paywallController: r.resolve(PaywallStateController.self)!) }
        container.register(BlockContextDataController.self, name: "default-data-controller") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!, interceptor: r.resolve(PaywallDataInterceptor.self)! )  }
        container.register(BlockContextDataController.self, name: "paywall-data-controller") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!) }
        container.register(TrackerFactory.self) { r in CoreTrackerFactory.init(delegate: r.resolve(BlockContextDataController.self, name: "default-data-controller")!)}
        container.register(CellFactory.self) { r in CoreCellFactory(trackerFactory: r.resolve(TrackerFactory.self)!) }
        container.register(AuthenticationController.self) { r in CoreAuthenticationController(paywallController: r.resolve(PaywallStateController.self)! )}
        container.register(URLHandler.self) { r in CoreURLHandler(paywallController: r.resolve(PaywallStateController.self)!, authController: r.resolve(AuthenticationController.self)!) }
        
        container.registerForStoryboard(MainViewController.self) { r, c in
            c.dataController = r.resolve(BlockContextDataController.self, name: "default-data-controller")
        }
        
        container.registerForStoryboard(TimelineViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandler.self)
            c.dataController = r.resolve(BlockContextDataController.self, name: "default-data-controller")
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: c.dataController)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }

        container.registerForStoryboard(ArticleViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandler.self)
            c.dataController = r.resolve(BlockContextDataController.self, name: "default-data-controller")
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: c.dataController)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }
        
        container.registerForStoryboard(PaywallViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandler.self)            
            c.dataController = r.resolve(BlockContextDataController.self, name: "paywall-data-controller")
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: c.dataController)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }
    }
}