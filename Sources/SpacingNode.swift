//
//  SpacingNode.swift
//  NRC
//
//  Created by Taco Vollmer on 27/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

/**
 Content for the SpacingNode. Spacing in points is calculated by multiplying a number of spacing units with a unit multiplier
 */
final class SpacingContent: Content {
    let units: CGFloat
    let multiplier: CGFloat
    
    var spacing: CGFloat {
        return units * multiplier
    }
    
    init(units: CGFloat, multiplier: CGFloat, backgroundColor: UIColor, padding: UIEdgeInsets = UIEdgeInsets()) {
        self.units = units
        self.multiplier = multiplier
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

/**
 Node for rendering a space between two other nodes
 */
final class SpacingNode: ContentNode<SpacingContent> {
    let spacingNode = ASDisplayNode()
    
    required init(content: SpacingContent) {
        super.init(content: content)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        spacingNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: content.spacing)
        return ASStaticLayoutSpec(children: [spacingNode])
    }
}
