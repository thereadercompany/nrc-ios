//
//  NRCCell.swift
//  NRC
//
//  Created by Taco Vollmer on 10/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/*
 NRC project level Cell - introduces cell decoration
 */
class NRCCell: Cell {
    let decoration: Decoration?
    let decorationNode: DecorationNode?
    
    init(contentNode: ASDisplayNode, decoration: Decoration?) {
        self.decoration = decoration
        decorationNode = DecorationNode(decoration: decoration)
        
        super.init(contentNode: contentNode)
        
        if let decorationNode = decorationNode {
            decorationNode.userInteractionEnabled = false
            addSubnode(decorationNode)
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayoutSpec = super.layoutSpecThatFits(constrainedSize)
        let decorationPadding = decoration?.padding ?? UIEdgeInsets()
        let decoratedContentSpec = ASInsetLayoutSpec(insets: decorationPadding, child: contentLayoutSpec)
        return ASBackgroundLayoutSpec(child: decoratedContentSpec, background: decorationNode)
    }
}
