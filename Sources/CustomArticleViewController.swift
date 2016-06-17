//
//  CustomArticleViewController.swift
//  boeckler
//
//  Created by Emiel van der Veen on 30/12/15.
//  Copyright © 2015 TRC. All rights reserved.
//

import Foundation

class CustomArticleViewController : ArticleViewController {
    
    let darkNavStyle = NavigationViewStyle.Dark(Colors.accentColor)
    
    override func navigationViewStyle(contentOffset contentOffset: CGFloat) -> NavigationViewStyle {
        guard let identifier = article?.blocks.first?.identifier else {
            return darkNavStyle
        }
        
        let nodes = collectionView.visibleNodes().filter { node in
            guard let node = node as? Cell else {
                return false
            }
            
            return node.block.identifier == identifier
        }
        
        guard let header = nodes.first as? ArticleHeaderCell else {
            return darkNavStyle
        }
        
        var rect = view.convertRect(navigationViewController.view.frame, toView: header.view)
        if rect.origin.y < 0 { rect.origin.y = 0 }
        
        let contains = header.imageRectContains(rect: rect)
        let style: NavigationViewStyle = contains ? .Transparent : darkNavStyle
        
        return style
    }
}