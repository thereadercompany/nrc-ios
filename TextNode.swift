//
//  TextNode.swift
//  NRC
//
//  Created by Taco Vollmer on 12/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class TextNodeContent: Content {
    let text: NSAttributedString
    
    init(text: NSAttributedString, backgroundColor: UIColor, padding: UIEdgeInsets = UIEdgeInsets()) {
        self.text = text
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class TextNode<C: TextNodeContent>: ContentNode<C>, ASTextNodeDelegate {
    let textNode = ASTextNode()
    
    required init(content: C) {
        super.init(content: content)
        addSubnode(textNode)
        textNode.attributedText = content.text
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let padding = content.padding
        let maxTextWidth = constrainedSize.max.width - padding.left - padding.right
        let maxTextSize = CGSize(width: maxTextWidth, height: constrainedSize.max.height)
        let textHeight = textNode.measure(maxTextSize).height
        
        let width = ASRelativeDimension(type: .Percent, value: 1)
        let minHeight = ASRelativeDimension(type: .Points, value: textHeight)
        let maxHeight = ASRelativeDimension(type: .Percent, value: 1)
        
        textNode.sizeRange = ASRelativeSizeRange(
            min: ASRelativeSize(width: width, height: minHeight),
            max: ASRelativeSize(width: width, height: maxHeight)
        )
        
        let textSpec = ASStaticLayoutSpec(children: [textNode])
        let insetSpec = ASInsetLayoutSpec(insets: content.padding, child: textSpec)
        return insetSpec
    }
}
