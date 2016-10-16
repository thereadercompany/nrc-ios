//
//  FallbackContentNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/**
 Node for rendering a block that has no dedicated Cell yet 
 */
final class FallbackContentNode: ASDisplayNode {
    private let textNode = ASTextNode()
    
    init(renderable: Renderable){
        super.init()
        
        backgroundColor = UIColor.randomColor().colorWithAlphaComponent(0.2)
        
        var string = "Uninplemented: \(renderable.dynamicType)"
        if let fallbackBlock = renderable as? FallbackBlock {
            string = "Fallback: \(fallbackBlock.originalType)"
        }
        
        let attributes = StringAttributes(font: Fonts.textFont.fallbackWithSize(15), foregroundColor: UIColor.grayColor())
        textNode.attributedText = NSAttributedString(string: string, attributes: attributes)
        addSubnode(textNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 0.5, child: textNode)
    }
}
