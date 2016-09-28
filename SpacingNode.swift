//
//  SpacingNode.swift
//  NRC
//
//  Created by Taco Vollmer on 27/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class SpacingContent: Content {
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

class SpacingNode<C: SpacingContent>: ContentNode<C> {
    let spacingNode = ASDisplayNode()
    
    required init(content: C) {
        super.init(content: content)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        spacingNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: content.spacing)
        return ASStaticLayoutSpec(children: [spacingNode])
    }
}
