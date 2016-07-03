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
        AppConfig.registerDefaults()
        
        let container = defaultContainer
        
        container.register(NetworkRequestHandler.self) { _  in CoreNetworkRequestHandler()}
        container.register(BlockDecoder.self) { _ in CustomBlockDecoder() }.inObjectScope(.Container)
        container.register(BlockContextDecoder.self) { _ in CustomBlockContextDecoder() }.inObjectScope(.Container)
        
        let databasePath = NSString(string: DefaultDirectories.documents).stringByAppendingPathComponent("store.sqlite")
        let databaseFactory = SQLiteDiskDatabaseFactory(databasePath: databasePath)
        
        container.register(Store.self) { r in SQLiteStore(factory: databaseFactory, blockDecoder: r.resolve(BlockDecoder.self)!, blockContextDecoder: r.resolve(BlockContextDecoder.self)!) }.inObjectScope(.Container)
        container.register(Cache.self) { r in CoreCache(store: r.resolve(Store.self)!) }.inObjectScope(.Container)
        container.register(PaywallStateController.self) { _ in CorePaywallStateController() }.inObjectScope(.Container)
        container.register(PaywallDataInterceptor.self) { r in CorePaywallDataInterceptor(paywallController: r.resolve(PaywallStateController.self)!) }.inObjectScope(.Container)
        container.register(BlockContextDataController.self, name: "default") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!, interceptor: r.resolve(PaywallDataInterceptor.self)! )  }.inObjectScope(.Container)
        container.register(BlockContextDataController.self, name: "paywall") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!) }.inObjectScope(.Container)
        container.register(TrackerFactory.self) { r in CoreTrackerFactory.init(delegate: r.resolve(BlockContextDataController.self, name: "default")!)}.inObjectScope(.Container)
        
        container.register(CellFactory.self) { r in CustomCellFactory(trackerFactory: r.resolve(TrackerFactory.self)!, dataController: r.resolve(BlockContextDataController.self, name: "default")!) }.inObjectScope(.Container)
        
        container.register(NavigationControllerDelegate.self) { r  in CustomNavigationControllerDelegate(cellFactory: r.resolve(CellFactory.self)!)}.inObjectScope(.Container)
        container.register(AuthenticationController.self) { r in CoreAuthenticationController(paywallController: r.resolve(PaywallStateController.self)! )}.inObjectScope(.Container)
        container.register(URLHandler.self) { r in CoreURLHandler(paywallController: r.resolve(PaywallStateController.self)!, authController: r.resolve(AuthenticationController.self)!) }.inObjectScope(.Container)
        
        container.register(BlockContextDataSource.self, name: "timeline") { r in BlockContextDataSource<Timeline>(blockContextRef: BlockContextRef.None, isSingleton:true, dataController: r.resolve(BlockContextDataController.self, name: "default")!)}.inObjectScope(.Container)

        container.register(BackgroundFetcher.self) { r in
            let fetcher = CoreBackgroundFetcher()
            fetcher.dataController = r.resolve(BlockContextDataController.self, name: "default")!
            fetcher.dataSource = r.resolve(BlockContextDataSource.self, name: "timeline")!
            return fetcher
        }.inObjectScope(.Container)
        
        container.registerForStoryboard(MainViewController.self) { r, c in
            c.dataController = r.resolve(BlockContextDataController.self, name: "default")
            c.delegate = r.resolve(NavigationControllerDelegate.self)
        }
        
        container.registerForStoryboard(TimelineViewController.self) { r, c in
            c.navigationViewController = CustomTimelineNavigationViewController()
            c.urlHandler = r.resolve(URLHandler.self)
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSource = r.resolve(BlockContextDataSource.self, name: "timeline")!
            c.articleDataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }

        container.registerForStoryboard(CustomArticleViewController.self) { r, c in
            c.navigationViewController = CoreArticleNavigationViewController()
            c.urlHandler = r.resolve(URLHandler.self)
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }
        
        container.registerForStoryboard(PaywallViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandler.self)            
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "paywall")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
        }
    }
}