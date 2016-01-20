//
//  CustomNavigationControllerDelegate.swift
//
//  Created by Emiel van der Veen on 15/01/16.
//

import Foundation

class CustomNavigationControllerDelegate : NSObject, NavigationControllerDelegate {
    
    let cellFactory: CellFactory
    
    init(cellFactory:CellFactory) {
        self.cellFactory = cellFactory
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch (operation, fromVC, toVC) {
        case (UINavigationControllerOperation.Push, let blockContextVC as BlockContextViewController, let articleVC as ArticleViewController):
            if let cell = blockContextVC.cellForReference(articleVC.articleReference) as? MediaCell {
                return MediaCellPushAnimator(cell: cell, cellFactory: cellFactory)
            }
        case (UINavigationControllerOperation.Pop, let articleVC as ArticleViewController, let blockContextVC as BlockContextViewController):
            if let cell = blockContextVC.cellForReference(articleVC.articleReference) as? MediaCell {
                return MediaCellPopAnimator(cell: cell)
            }
        case (UINavigationControllerOperation.Push, _, let imageVC as ImageViewController):
            if let cell = imageVC.mediaCell {
                return ImagePushAnimator(mediaCell: cell)
            }
        case (UINavigationControllerOperation.Pop, let imageVC as ImageViewController, _):
            if let cell = imageVC.mediaCell {
                return ImagePopAnimator(mediaCell: cell)
            }
        default: ()
        }
        
        return nil
    }
}
