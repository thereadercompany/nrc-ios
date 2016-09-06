//
//  ContentNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class CellContent {
    init(){}
    var backgroundColor = UIColor.whiteColor()

    var decoration: BlockDecoration = .None
    var decorationModel: DecorationModel? = nil
    var decorationPadding: UIEdgeInsets {
        return decorationModel?.padding(decoration: decoration) ?? UIEdgeInsets()
    }
    var contentPadding = UIEdgeInsets()
    var totalPadding: UIEdgeInsets {
        return decorationPadding + contentPadding
    }

    var decorationNode: DecorationNode? {
        guard let model = decorationModel else { return nil }
        return DecorationNode(model: model, decoration: decoration)
    }
    
    var action: CellAction? = nil
}

class ContentNode<C: CellContent>: ASDisplayNode, ActionProvider {
    let model: C
    let decorationNode: DecorationNode?
    
    required init(model: C) {
        self.model = model
        decorationNode = model.decorationNode
        super.init()
        
        backgroundColor = model.backgroundColor
        
        if let decorationNode = decorationNode {
            // addsubnode is overridden. super implementation is needed for decoration node itself
            super.addSubnode(decorationNode)
        }
    }
    
    // subnodes are added below the decoration node if it exists
    override func addSubnode(subnode: ASDisplayNode) {
        guard let decorationNode = decorationNode else {
            super.addSubnode(subnode)
            return
        }
        
        insertSubnode(subnode, belowSubnode: decorationNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayoutSpec = contentLayoutSpecThatFits(constrainedSize)
        let decoratedContentSpec = ASInsetLayoutSpec(insets: model.decorationPadding, child: contentLayoutSpec)
        return ASBackgroundLayoutSpec(child: decoratedContentSpec, background: decorationNode)
    }
    
    // MARK: - subclasses
    
    //override in subclasses to provide the layoutspec for the content
    func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASLayoutSpec()
    }
    
    //MARK: - action provider
    var action: CellAction? {
        return nil
    }
}