//
//  BylineNode.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/12/15.
//  Copyright © 2015 The Reader Company. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class BylineContent: Content {
    let icon: InlineIcon
    let text: NSAttributedString
    
    init(icon: InlineIcon,
         text: NSAttributedString,
         backgroundColor: UIColor = .whiteColor(),
         padding: UIEdgeInsets = UIEdgeInsets()
        ) {
        self.icon = icon
        self.text = text
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class BylineNode: ContentNode<BylineContent> {
    let iconNode = ASImageNode()
    let textNode = ASTextNode()
    let padding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 3, right: ArticleStyles.textInset)
    
    required init(content: BylineContent) {
        super.init(content: content)
        self.addSubnode(iconNode)
        self.addSubnode(textNode)
        iconNode.image = content.icon.image
        textNode.attributedText = content.text
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        iconNode.preferredFrameSize = CGSize(width: 12, height: 12)
        iconNode.spacingAfter = 8
        
        // set the ascender to the height of the image, so the bottom of the image will alingn with the fist baseline of the text with .BaselineFirst in the stack
        iconNode.ascender = 12
        textNode.flexBasis = ASRelativeDimension(type: .Percent, value: 1)
        
        let columnSpec = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: .Start, alignItems: .BaselineFirst, children: [iconNode, textNode])
        return ASInsetLayoutSpec(insets: padding, child: columnSpec)
    }
}
