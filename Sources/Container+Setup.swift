//
//  Swinject.Container+Setup.swift
//  boeckler
//
//  Created by Emiel van der Veen on 24/11/15.
//

import Foundation
import Swinject

extension Swinject.Container {
    class func setup() -> Container {
        AppConfig.registerDefaults()
        
        let container = self.init() { c in
            c.register(NetworkRequestHandler.self) { _  in CoreNetworkRequestHandler()}
            c.register(BlockDecoder.self) { _ in CustomBlockDecoder() }.inObjectScope(.Container)
            c.register(BlockContextDecoder.self) { _ in CustomBlockContextDecoder() }.inObjectScope(.Container)
            
            let databasePath = NSString(string: DefaultDirectories.documents).stringByAppendingPathComponent("store.sqlite")
            let databaseFactory = SQLiteDiskDatabaseFactory(databasePath: databasePath)
            
            c.register(Store.self) { r in SQLiteStore(factory: databaseFactory, blockDecoder: r.resolve(BlockDecoder.self)!, blockContextDecoder: r.resolve(BlockContextDecoder.self)!) }.inObjectScope(.Container)
            c.register(Cache.self) { r in CoreCache(store: r.resolve(Store.self)!) }.inObjectScope(.Container)
            c.register(PaywallStateController.self) { _ in CorePaywallStateController() }.inObjectScope(.Container)
            c.register(PaywallDataInterceptor.self) { r in CorePaywallDataInterceptor(paywallController: r.resolve(PaywallStateController.self)!) }.inObjectScope(.Container)
            c.register(BlockContextDataController.self, name: "default") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!, interceptor: r.resolve(PaywallDataInterceptor.self)! )  }.inObjectScope(.Container)
            c.register(BlockContextDataController.self, name: "paywall") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!) }.inObjectScope(.Container)
            c.register(TrackerFactory.self) { r in CoreTrackerFactory.init(delegate: r.resolve(BlockContextDataController.self, name: "default")!)}.inObjectScope(.Container)
            
            c.register(CellFactory.self) { r in CustomCellFactory(trackerFactory: r.resolve(TrackerFactory.self)!, dataController: r.resolve(BlockContextDataController.self, name: "default")!) }.inObjectScope(.Container)
            
            c.register(NavigationControllerDelegate.self) { r  in CustomNavigationControllerDelegate(cellFactory: r.resolve(CellFactory.self)!)}.inObjectScope(.Container)
            c.register(AuthenticationController.self) { r in CoreAuthenticationController(paywallController: r.resolve(PaywallStateController.self)! )}.inObjectScope(.Container)
            c.register(URLHandler.self) { r in CoreURLHandler(paywallController: r.resolve(PaywallStateController.self)!, authController: r.resolve(AuthenticationController.self)!) }.inObjectScope(.Container)
            
            c.register(BlockContextDataSource.self, name: "timeline") { r in BlockContextDataSource<Timeline>(blockContextRef: BlockContextRef.None, isSingleton:true, dataController: r.resolve(BlockContextDataController.self, name: "default")!)}.inObjectScope(.Container)

            
            c.register(BackgroundFetcher.self) { r in
                let fetcher = CoreBackgroundFetcher()
                fetcher.dataController = r.resolve(BlockContextDataController.self, name: "default")!
                fetcher.dataSource = r.resolve(BlockContextDataSource.self, name: "timeline")!
                return fetcher
                }.inObjectScope(.Container)
            
            c.register(TimelineViewController.self) { r in
                let t = TimelineViewController()
                t.navigationViewController = CustomTimelineNavigationViewController()
                t.urlHandler = r.resolve(URLHandler.self)
                t.cellFactory = r.resolve(CellFactory.self)
                t.dataSource = r.resolve(BlockContextDataSource.self, name: "timeline")!
                t.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
                return t
            }
            
            c.register(MainViewController.self) { r in
                let timelineViewController = r.resolve(TimelineViewController.self)!
                let mainViewController = MainViewController(rootViewController: timelineViewController)
                mainViewController.dataController = r.resolve(BlockContextDataController.self, name: "default")
                mainViewController.delegate = r.resolve(NavigationControllerDelegate.self)
                return mainViewController
            }
            
            c.register(ArticleViewController.self) { r in
                let c = CustomArticleViewController()
                c.navigationViewController = CoreArticleNavigationViewController()
                c.urlHandler = r.resolve(URLHandler.self)
                c.cellFactory = r.resolve(CellFactory.self)
                c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "default")!)
                c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
                return c
            }
            
            c.register(PaywallViewController.self) { r in
                let p = PaywallViewController()
                p.urlHandler = r.resolve(URLHandler.self)
                p.cellFactory = r.resolve(CellFactory.self)
                p.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "paywall")!)
                p.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
                return p
            }
        }
        
        return container
    }
}