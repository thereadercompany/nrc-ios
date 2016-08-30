
//  SectionRefCell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class SectionHeaderCell: Cell {
    let labelNode = ASTextNode()
    let sizeNode = ASDisplayNode()
    
    init(sectionRef: SectionRefBlock, styles: CellStyles) {
        super.init(block: sectionRef, styles: styles)
        let attributes = StringAttributes(font: Fonts.boldFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor(), alignment: .Left)
        labelNode.attributedString = NSMutableAttributedString(string: sectionRef.label, attributes: attributes.dictionary)
        addSubnode(labelNode)
        
        backgroundColor = UIColor.lightGrayColor()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        sizeNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: 50)
        let centeredContent = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: labelNode)
        let sizedContent = ASOverlayLayoutSpec(child: sizeNode, overlay: centeredContent)
        return sizedContent
//        let decoratedSpec = ASInsetLayoutSpec(insets: block.decorationPadding, child: sizedContent)
//        let backgroundSpec = ASBackgroundLayoutSpec(child: decoratedSpec, background: decorationNode)
//        return backgroundSpec
    }
}
