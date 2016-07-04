//
//  CustomBackgroundFetchStrategy.swift
//
//  Created by Emiel van der Veen on 04/07/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import RxSwift

class CustomBackgroundFetchStrategy : BackgroundFetchStrategy {
    var dataController: BlockContextDataController!
    private var updateSubject: PublishSubject<Bool>!
    private var running: Bool = false
    private var articleDataSources: [String:BlockContextDataSource<Article>] = [:]
    
    private var isReachableViaWiFi: Bool {
        do {
            return try Reachability.reachabilityForInternetConnection().isReachableViaWiFi()
        } catch {
            return false
        }
    }
    
    func nextRunLoop(timeline: Timeline) -> Observable<Bool>? {
        assert(!running, "only one active runloop allowed")
        if running { return nil }
        
        // prio 1: fetch all article ref images
        if !fetchNextImage(timeline) {
            // prio 2: fetch all article blocks
            if !fetchNextArticle(timeline) {
                // prio 3: fetch all images inside articles
                if !fetchNextArticleImage(timeline) {
                    return nil
                }
            }
        }
        
        running = true
        updateSubject = PublishSubject()
        return updateSubject
    }
    
    func completeRunLoop(error: ErrorType? = nil) {
        if let error = error {
            updateSubject.onError(error)
        } else {
            updateSubject.onCompleted()
        }
        updateSubject = nil
        running = false
    }
    
    func reset() {
        articleDataSources.removeAll()
    }
    
    private func readArticleFromDatabase(identifier: String) -> Article? {
        return articleDataSource(identifier).blockContext
    }
    
    private func articleDataSource(identifier:String) -> BlockContextDataSource<Article> {
        if let articleDataSource = articleDataSources[identifier] {
            return articleDataSource
        }
        
        let ref = BlockContextRef<Article>.Identifier(identifier)
        let articleDataSource = BlockContextDataSource<Article>(blockContextRef: ref, isSingleton: false, dataController: dataController)
        articleDataSources[identifier] = articleDataSource
        return articleDataSource
    }
    
    private func fetchNextImage(blockContext: BlockContext) -> Bool {
        for block in (blockContext.blocks) {
            if let mediaBlock = block as? MediaBlock {
                if fetchImage(mediaBlock) { return true }
            }
        }
        return false
    }
    
    private func fetchImage(mediaBlock: MediaBlock) -> Bool {
        if mediaBlock.media.identifier.isEmpty { return false }
        
        let supportedMediaFormats = mediaBlock.supportedMediaFormats
        let URL = mediaBlock.media.URL(forFormat: isReachableViaWiFi ? supportedMediaFormats.first! : supportedMediaFormats.last!)
        return fetchImage(URL)
    }
    
    private func fetchImage(URL: NSURL) -> Bool {
        if !ImageController.shared.isImageAvailable(URL) {
            ImageController.shared.loadImageWithURL(URL) { [unowned self] (image, error) -> Void in
                self.completeRunLoop()
            }
            return true
        } else {
            return false
        }
    }
    
    private func fetchNextArticle(timeline: Timeline) -> Bool {
        for block in (timeline.blocks) {
            if let articleRefBlock = block as? ArticleRefBlock {
                if fetchArticle(articleRefBlock) { return true }
            }
        }
        return false
    }
    
    private func fetchArticle(articleRefBlock: ArticleRefBlock) -> Bool {
        let articleDataSource = self.articleDataSource(articleRefBlock.reference.identifier)
        if !articleDataSource.moreBlocksAvailable { return false }
        
        let _ = articleDataSource.updateObservable.takeUntil(articleDataSource.errorObservable).take(1).subscribeNext { [unowned self] (update) in
            self.completeRunLoop()
        }
        let _ = articleDataSource.errorObservable.takeUntil(articleDataSource.updateObservable).take(1).subscribeNext { [unowned self] (error) in
            self.completeRunLoop(error)
        }
        articleDataSource.reload(compact: false, patchEnabled: false)
        return true
    }
    
    private func fetchNextArticleImage(timeline:Timeline) -> Bool {
        for timelineBlock in timeline.blocks {
            if let articleRefBlock = timelineBlock as? ArticleRefBlock, let article = readArticleFromDatabase(articleRefBlock.reference.identifier) {
                if fetchNextImage(article) { return true }
            }
        }
        return false
    }
}