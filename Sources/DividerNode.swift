//
//  DividerCell.swift
//  NRC
//
//  Created by Taco Vollmer on 13/09/16
//  Copyright (c) 2015 The Reader Company. All rights reserved.
//

import Foundation
import AsyncDisplayKit

/**
 Content for the DividerNode
 */
final class DividerNodeContent: Content {
    let line: Line
    let label: Label?
    
    init(line: Line, label: Label? = nil, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.line = line
        self.label = label
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

/**
 Node for rendering a horizontal dividing line with optional label
 */
final class DividerNode : ContentNode<DividerNodeContent> {
    let leftLine = ASDisplayNode()
    let rightLine = ASDisplayNode()
    let labelNode: LabelNode?
    
    required init(content: DividerNodeContent) {
        labelNode = LabelNode(label: content.label)
        
        super.init(content: content)
        
        addSubnode(leftLine)
        leftLine.backgroundColor = content.line.color
        
        addSubnode(rightLine)
        rightLine.backgroundColor = content.line.color
        
        addOptionalSubnode(labelNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let lineHeight = content.line.size.height
        
        leftLine.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: lineHeight)
        leftLine.flexShrink = true
        
        rightLine.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: lineHeight)
        rightLine.flexShrink = true
        
        let nodes: [ASLayoutable?] = [leftLine, labelNode, rightLine]
        let columnSpec = ASStackLayoutSpec(direction: .Horizontal, justifyContent: .Center, alignItems: .Center, optionalChildren: nodes)
        return ASInsetLayoutSpec(insets: content.padding, child: columnSpec)
    }
}
