
//  SectionHeaderNode.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class SectionHeaderContent: CellContent {
    let title: NSAttributedString
    let height: CGFloat
    
    init(title: NSAttributedString,
         height: CGFloat = 50,
         backgroundColor: UIColor = .whiteColor(),
         padding: UIEdgeInsets = UIEdgeInsets()
        ) {
        self.title = title
        self.height = height
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class SectionHeaderNode: ContentNode<SectionHeaderContent> {
    let titleNode = ASTextNode()
    let sizeNode = ASDisplayNode()
    
    required init(content: SectionHeaderContent) {
        super.init(content: content)
        titleNode.attributedText = content.title
        addSubnode(titleNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        sizeNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: content.height)
        let centeredContent = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: titleNode)
        let insettedContent = ASInsetLayoutSpec(insets: content.padding, child: centeredContent)
        let sizedContent = ASOverlayLayoutSpec(child: sizeNode, overlay: insettedContent)
        return sizedContent
    }
}
