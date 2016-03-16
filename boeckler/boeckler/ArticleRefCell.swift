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
    
    init(articleRef: ArticleRefBlock, dataController: BlockContextDataController, cellFactory: CellFactory) {
        self.articleRef = articleRef
        self.dataController = dataController
        self.cellFactory = cellFactory
        super.init(block: articleRef)        
    }
    
    override func scrollViewHalted(halted: Bool) {
        super.scrollViewHalted(halted)
        if halted && preview == nil {
            preview = renderPreview()
        }
    }
    
    override func setVisible(visible: Bool) {
        super.setVisible(visible)
        if !visible {
            preview = nil
        }
    }
    
    //MARK: - Snapshot
    var articlePreviewSnapshot: UIImage?

    func renderPreview() -> ArticlePreview? {
        guard let article: Article = dataController.readBlockContext(identifier: articleRef.articleIdentifier) else {
            print("No article found in articleVC while snappshotting")
            return nil
        }
        let size = UIScreen.mainScreen().bounds.size
        return ArticlePreview(article: article, frame: CGRect(origin: CGPointZero, size: size), cellFactory: cellFactory)
    }
    
    var articlePreviewSnapshotFrame: CGRect {
        let screenSize = UIScreen.mainScreen().bounds.size
        let imageHeight = ArticleHeaderCellStyles.imageHeight
        return CGRect(x: 0, y: imageHeight, width: screenSize.width, height: screenSize.height)
    }

    func takeArticlePreviewSnapshot(completion: (snapshot: UIImage?) -> Void) {
        if preview == nil {
            self.preview = renderPreview()
        }
        
        if let preview = self.preview {
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                let snapshot = preview.takeSnapshot(bounds: self.articlePreviewSnapshotFrame)
                completion(snapshot: snapshot)
            }
        }
    }
}