//
//  SectionHeaderNode.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/**
 Content for the SectionRefNode
 */
final class SectionRefNodeContent: Content {
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

/**
 Node for rendering a sectionRef with a title
 */
final class SectionRefNode: ContentNode<SectionRefNodeContent> {
    let titleNode = ASTextNode()
    
    required init(content: SectionRefNodeContent) {
        super.init(content: content)
        titleNode.attributedText = content.title
        addSubnode(titleNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centeredContentSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: titleNode)
        let paddedContentSpec = ASInsetLayoutSpec(insets: content.padding, child: centeredContentSpec)
        
        // stretch to max width and set the height
        let size = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Points, value: content.height)
        )
        paddedContentSpec.sizeRange = ASRelativeSizeRange(min: size, max: size)
        
        return ASStaticLayoutSpec(children: [paddedContentSpec])
    }
}
