//
//  SwinjectStoryboard+Setup.swift
//  boeckler
//
//  Created by Emiel van der Veen on 24/11/15.
//

import Foundation
import Swinject
import Core
import RxCocoa

extension SwinjectStoryboard {
    class func setup() {
        AppConfig.registerDefaults()
        
        let container = defaultContainer

        container.register(ErrorMessageViewStyles.self) { _ in ErrorMessageViewStyles(
            backgroundColor: Colors.errorBackgroundColor, messageTextColor: Colors.errorMessageTextColor, messageFont: ErrorStyles.messageFont, titleFont: ErrorStyles.buttonFont, titleColor: Colors.errorActionButtonTextColor, highlightedTitleColor: Colors.errorMessageTextColor) }

        container.register(NetworkRequestHandler.self) { _  in CoreNetworkRequestHandler()}
        container.register(BlockDecoder.self) { _ in CustomBlockDecoder() }.inObjectScope(.Container)
        container.register(BlockContextDecoder.self) { _ in CustomBlockContextDecoder() }.inObjectScope(.Container)
        
        let databasePath = NSString(string: DefaultDirectories.documents).stringByAppendingPathComponent("store.sqlite")
        let databaseFactory = SQLiteDiskDatabaseFactory(databasePath: databasePath)
        
        container.register(Store.self) { r in SQLiteStore(factory: databaseFactory, blockDecoder: r.resolve(BlockDecoder.self)!, blockContextDecoder: r.resolve(BlockContextDecoder.self)!) }.inObjectScope(.Container)
        container.register(Cache.self) { r in CoreCache(store: r.resolve(Store.self)!) }.inObjectScope(.Container)
        container.register(PaywallStateController.self) { _ in CorePaywallStateController() }.inObjectScope(.Container)
        container.register(PaywallDataInterceptor.self) { r in CorePaywallDataInterceptor(paywallController: r.resolve(PaywallStateController.self)!) }.inObjectScope(.Container)
        container.register(BlockContextDataController.self, name: "default") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!, baseServerURL: apiBaseURL(), interceptor: r.resolve(PaywallDataInterceptor.self)! )  }.inObjectScope(.Container)
        container.register(BlockContextDataController.self, name: "paywall") { r in CoreBlockContextDataController(cache: r.resolve(Cache.self)!, networkRequestHandler: r.resolve(NetworkRequestHandler.self)!, baseServerURL: apiBaseURL()) }.inObjectScope(.Container)
        container.register(TrackerFactory.self) { r in CoreTrackerFactory.init(delegate: r.resolve(BlockContextDataController.self, name: "default")!)}.inObjectScope(.Container)
        
        container.register(CellFactory.self) { r in CustomCellFactory(trackerFactory: r.resolve(TrackerFactory.self)!, dataController: r.resolve(BlockContextDataController.self, name: "default")!) }.inObjectScope(.Container)
        
        container.register(NavigationControllerDelegate.self) { r  in CustomNavigationControllerDelegate(cellFactory: r.resolve(CellFactory.self)!)}.inObjectScope(.Container)
        container.register(AuthenticationController.self) { r in CoreAuthenticationController(paywallController: r.resolve(PaywallStateController.self)!, authURL: serverBaseURL(), errorStyles: r.resolve(ErrorMessageViewStyles.self)!)}.inObjectScope(.Container)
        container.register(URLHandler.self) { r in CoreURLHandler(paywallController: r.resolve(PaywallStateController.self)!, authController: r.resolve(AuthenticationController.self)!) }.inObjectScope(.Container)
        
        container.register(BlockDataSource.self, name: "timeline") { r in
            BlockContextDataSource<Timeline>(blockContextRef: BlockContextRef.None, isSingleton:false, dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            }.inObjectScope(.Container)

        container.register(BlockDataSource.self, name: "menu") { r in
            BlockContextDataSource<Menu>(blockContextRef: BlockContextRef.None, isSingleton:false, dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            }.inObjectScope(.Container)

        container.register(BackgroundFetchStrategy.self) { r in
            let strategy = CustomBackgroundFetchStrategy()
            strategy.dataController = r.resolve(BlockContextDataController.self, name: "default")!
            return strategy
            }.inObjectScope(.Container)
        
        
        container.register(BackgroundFetcher.self) { r in
            let fetcher = CoreBackgroundFetcher()
            fetcher.strategy = r.resolve(BackgroundFetchStrategy.self)!
            fetcher.dataController = r.resolve(BlockContextDataController.self, name: "default")!
            fetcher.dataSource = r.resolve(BlockContextDataSource.self, name: "timeline")!
            return fetcher
        }.inObjectScope(.Container)
        
        container.registerForStoryboard(MainViewController.self) { r, c in
            c.dataController = r.resolve(BlockContextDataController.self, name: "default")
            c.delegate = r.resolve(NavigationControllerDelegate.self)
        }
        
        container.registerForStoryboard(TimelineViewController.self) { r, c in
            let navController = CustomTimelineNavigationViewController()
            c.navigationViewController = navController
            c.urlHandler = r.resolve(URLHandler.self)
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSource = r.resolve(BlockDataSource.self, name: "timeline")!
            c.articleDataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
            c.backgroundColor = TimelineStyles.backgroundColorBoot
            c.refreshControl.tintColor = LoadingStyles.refreshControlTintColor
            c.errorStyles = r.resolve(ErrorMessageViewStyles.self)!

            _ = navController.timelineNavigationView.menuButton.rx_tap.takeUntil(c.rx_deallocated).subscribeNext({ (_) in
                let controller = UINavigationController(rootViewController: HTMLMenuViewController())
//                controller.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
//                controller.dataSource = r.resolve(BlockDataSource.self, name: "menu")
//                c.cellFactory = r.resolve(CellFactory.self)
                controller.modalPresentationStyle = .FullScreen
                c.showViewController(controller, sender: nil)
            })
        }

        container.registerForStoryboard(CustomArticleViewController.self) { r, c in
            c.navigationViewController = CoreArticleNavigationViewController(autoHideNavBar: true, accentColor: Colors.accentColor)

            c.urlHandler = r.resolve(URLHandler.self)
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "default")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
            c.styles = ArticleViewControllerStyles(pushToHideThreshold: ArticleStyles.pushToHideThreshold, navigationBarHeight: ArticleStyles.navigationBarHeight, topInset: ArticleStyles.topInset, backgroundColor: { (article) -> UIColor in
                ArticleStyles.backgroundColor
            })
            c.errorStyles = r.resolve(ErrorMessageViewStyles.self)!
        }
        
        container.registerForStoryboard(PaywallViewController.self) { r, c in
            c.urlHandler = r.resolve(URLHandler.self)            
            c.cellFactory = r.resolve(CellFactory.self)
            c.dataSourceFactory = BlockContextDataSourceFactory(dataController: r.resolve(BlockContextDataController.self, name: "paywall")!)
            c.visibilityStateController = CoreVisibilityStateController(trackerFactory: r.resolve(TrackerFactory.self)!)
            c.errorStyles = r.resolve(ErrorMessageViewStyles.self)!
        }
    }
}