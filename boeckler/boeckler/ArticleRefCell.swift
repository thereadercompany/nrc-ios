//
//  ArticleRefCell.swift
//
//  Created by Emiel van der Veen on 18/02/16.
//

import Foundation

class ArticleRefCell : MediaCell {
    let articleRef: ArticleRefBlock

    let dataController: BlockContextDataController
    let cellFactory: CellFactory
    var preview: ArticlePreview?
    var previewOrientation: UIInterfaceOrientation?
    
    init(articleRef: ArticleRefBlock, dataController: BlockContextDataController, cellFactory: CellFactory) {
        self.articleRef = articleRef
        self.dataController = dataController
        self.cellFactory = cellFactory
        super.init(block: articleRef)        
    }
    
    override func scrollViewHalted() {
        super.scrollViewHalted()
        updatePreview()
    }
    
    private func setPreview() {
        preview = renderPreview()
        previewOrientation = UIApplication.sharedApplication().statusBarOrientation
    }
    
    private func resetPreview() {
        preview = nil
        previewOrientation = nil
        articlePreviewSnapshot = nil
    }
    
    private func updatePreview() {
        let currentOrientation = UIApplication.sharedApplication().statusBarOrientation
        if previewOrientation != currentOrientation {
            resetPreview()
        }
        if preview == nil {
            setPreview()
        }
    }
        
    override func setVisible(visible: Bool) {
        super.setVisible(visible)
        if !visible {
            preview = nil
            previewOrientation = nil
        }
    }
    
    //MARK: - Snapshot
    var articlePreviewSnapshot: UIImage?

    func renderPreview() -> ArticlePreview? {
        guard let article: Article = dataController.read(identifier: articleRef.articleIdentifier) else {
            print("No article found in articleVC while snappshotting")
            return nil
        }
        let size = Screen.size
        return ArticlePreview(article: article, frame: CGRect(origin: CGPointZero, size: size), cellFactory: cellFactory)
    }
    
    var articlePreviewSnapshotFrame: CGRect {
        let size = Screen.size
        let imageHeight = ArticleHeaderCellStyles.imageHeight
        return CGRect(x: 0, y: imageHeight, width: size.width, height: size.height)
    }

    func takeArticlePreviewSnapshot(completion: (snapshot: UIImage?) -> Void) {
        updatePreview()
        
        if let preview = self.preview {
            NSThread.currentThread().isMainThread
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                let bounds = self.articlePreviewSnapshotFrame
                let snapshot = preview.takeSnapshot(bounds: bounds)
                completion(snapshot: snapshot)
            }
        }
    }
}