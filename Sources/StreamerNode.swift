//
//  StreamerNode.swift
//  NRC
//
//  Created by Taco Vollmer on 18/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class StreamerNodeContent: Content {
    let text: NSAttributedString
    let source: NSAttributedString?
    let lines: (top: Line, bottom: Line)
    
    init(text: NSAttributedString, source: NSAttributedString?, lines: (Line, Line), backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.text = text
        self.source = source
        self.lines = lines
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class StreamerNode: ContentNode<StreamerNodeContent> {
    let topLineNode = ASDisplayNode()
    let textNode: ASTextNode
    let sourceNode: ASTextNode?
    let bottomLineNode = ASDisplayNode()
    
    //MARK: - Init
    required init(content: StreamerNodeContent) {
        sourceNode = ASTextNode(optionalText: content.source)
        textNode = ASTextNode(text: content.text)
        super.init(content: content)
        
        // top line
        topLineNode.backgroundColor = content.lines.top.color
        addSubnode(topLineNode)
        
        // text
        addSubnode(textNode)
        addOptionalSubnode(sourceNode)
        
        // bottom line
        bottomLineNode.backgroundColor = content.lines.bottom.color
        addSubnode(bottomLineNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        textNode.spacingBefore = 18
        textNode.spacingAfter = 14
        sourceNode?.spacingAfter = 18
        
        // fix line size
        let topLineSize = ASRelativeSize(width: ASRelativeDimension(type: .Points, value: content.lines.top.size.width),
                                         height: ASRelativeDimension(type: .Points, value: content.lines.top.size.height)
        )
        topLineNode.sizeRange = ASRelativeSizeRange(min: topLineSize, max: topLineSize)
        let topLineSpec = ASStaticLayoutSpec(children: [topLineNode])
        
        let bottomLineSize = ASRelativeSize(width: ASRelativeDimension(type: .Points, value: content.lines.bottom.size.width),
                                           height: ASRelativeDimension(type: .Points, value: content.lines.bottom.size.height)
        )
        bottomLineNode.sizeRange = ASRelativeSizeRange(min: bottomLineSize, max: bottomLineSize)
        let bottomLineSpec = ASStaticLayoutSpec(children: [bottomLineNode])
        
        // stack nodes
        let nodes: [ASLayoutable?] = [topLineSpec, textNode, sourceNode, bottomLineSpec]
        let contentSpec = ASStackLayoutSpec(direction: .Vertical, alignItems: .Stretch, optionalChildren: nodes)
        
        // add content padding
        let paddedContentSpec = ASInsetLayoutSpec(insets: content.padding, child: contentSpec)
        
        // fix size full width
        let minSize = ASRelativeSize(width: ASRelativeDimension(type: .Percent, value: 1),
                                  height: ASRelativeDimension(type: .Percent, value: 0)
        )
        let maxSize = ASRelativeSize(width: ASRelativeDimension(type: .Percent, value: 1),
                                     height: ASRelativeDimension(type: .Percent, value: 1)
        )
        paddedContentSpec.sizeRange = ASRelativeSizeRange(min: minSize, max: maxSize)
        
        return ASStaticLayoutSpec(children: [paddedContentSpec])
    }
}
