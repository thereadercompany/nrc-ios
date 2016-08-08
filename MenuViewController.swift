//
//  MenuViewController.swift
//  boeckler-ios
//
//  Created by Jeroen Vloothuis on 31-07-16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Core
import BrightFutures
import RxSwift




public class MenuViewController: BlockContextViewController {
    //public override var dataSource: BlockDataSource! = BlockContextDataSource<Menu>

    var menu: Menu?

    override public func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = UIColor.yellowColor()
        collectionView.asyncDataSource = self
        collectionView.layoutIfNeeded()
        reload()

        applyRx()

        dataSource.reload(compact: true, patchEnabled: false)
    }

    func applyRx() {
//        dataSource.updateObservable.subscribeNext { [unowned self] update in
//            if let article = update.blockContext as? Article {
//                self.updateContext(article, changes: update.changes)
//            }
//            }
//
//        dataSource.errorObservable.subscribeNext { [unowned self] error in
//            if self.dataSource.blockContext?.moreBlocksAvailable ?? true {
//                self.showErrorMessage(error, networkUnavailableWarningEnabled: true, retryBlock: nil)
//            }
//            }
    }


    func updateContext(article: Article, changes: BlockChanges?) {
        assert(NSThread.isMainThread(), "expect main thread")

//        self.article = article
        if let changes = changes {
//            self.applyChanges(changes)
        } else {
            self.collectionView.reloadData()
        }
    }

    func reload() {
        dataSource.reload(compact: true, patchEnabled: false)
    }

    func swipeGestureRecognized(gesture: UISwipeGestureRecognizer) {
        self.navigationController?.popViewControllerAnimated(true)
    }


    //MARK: - CellDelegate
    public override func handleCellAction(cell: Cell, cellAction: CellAction) {
        // FIXME: Dismiss menu or something
        super.handleCellAction(cell, cellAction: cellAction)
    }
}
