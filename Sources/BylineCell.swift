//
//  BylineCell.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/12/15.
//  Copyright © 2015 The Reader Company. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class BylineCell: Core.Cell {
    let iconNode = ASImageNode()
    let textNode = ASTextNode()
    let padding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 3, right: ArticleStyles.textInset)
    
    let bylineBlock: BylineBlock
    
    init(bylineBlock: BylineBlock, styles: CellStyles) {
        self.bylineBlock = bylineBlock
        super.init(block: bylineBlock, styles: styles)
        self.addSubnode(iconNode)
        self.addSubnode(textNode)
        iconNode.image = bylineBlock.icon.image
        
        let font = Fonts.alternativeMediumFont.fallbackWithSize(15)
        let attributes = StringAttributes(font: font, foregroundColor: Colors.defaultFontColor, lineSpacing: 3).dictionary
        textNode.attributedText = NSAttributedString(string: bylineBlock.plainText, attributes: attributes)
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
