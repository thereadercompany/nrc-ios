
//  SectionRefCell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class SectionHeaderCell: Core.Cell {
    let labelNode = ASTextNode()
    let sizeNode = ASDisplayNode()
    
    init(sectionRef: SectionRefBlock, styles: CellStyles) {
        super.init(block: sectionRef, styles: styles)
        let attributes = StringAttributes(font: Fonts.boldFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor(), alignment: .Left)
        labelNode.attributedString = NSMutableAttributedString(string: sectionRef.title, attributes: attributes.dictionary)
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

class SectionHeaderContent: CellContent {
    let title: NSAttributedString
    let height: CGFloat
    
    init(title: NSAttributedString, height: CGFloat = 50) {
        self.title = title
        self.height = height
    }
}

class SectionHeaderNode: ContentNode<SectionHeaderContent> {
    let titleNode = ASTextNode()
    let sizeNode = ASDisplayNode()
    
    required init(model: SectionHeaderContent) {
        super.init(model: model)
        titleNode.attributedText = model.title
        addSubnode(titleNode)
    }
    
    override func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let decorationPadding = model.decorationPadding
        let heightInsets = UIEdgeInsets(top: decorationPadding.top, left: 0, bottom: decorationPadding.bottom, right: 0)
        
        let height = model.height + heightInsets.top + heightInsets.bottom
        sizeNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: height)
        
        let centeredContent = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: titleNode)
        let insettedContent = ASInsetLayoutSpec(insets: heightInsets, child: centeredContent)
        let sizedContent = ASOverlayLayoutSpec(child: sizeNode, overlay: insettedContent)
        return sizedContent
    }

}
