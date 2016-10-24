//
//  LabelNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/**
 Model object for the `LabelNode`
 */
struct Label {
    let text: NSAttributedString
    let insets: UIEdgeInsets
    let backgroundColor: UIColor?
    let corners: CornerInfo?
    let border: Border?
    let bullet: Bullet?
    
    init (text: NSAttributedString,
          insets: UIEdgeInsets,
          backgroundColor: UIColor? = nil,
          corners: CornerInfo? = nil,
          border: Border? = nil,
          bullet: Bullet? = nil) {
        self.text = text
        self.insets = insets
        self.backgroundColor = backgroundColor
        self.corners = corners
        self.border = border
        self.bullet = bullet
    }
}

/**
 Node for rendering a `Label`
 */
final class LabelNode : ASDisplayNode {
    let textNode: ASTextNode
    let bulletNode: ASDisplayNode?
    
    let label: Label
    
    init(label: Label) {
        self.label = label
        textNode = ASTextNode(text: label.text)
        bulletNode = BulletNode(optionalBullet: label.bullet)
        
        super.init()
        
        backgroundColor = label.backgroundColor
        cornerRadius = label.corners?.radius ?? 0
        borderColor = label.border?.color.CGColor
        borderWidth = label.border?.width ?? 0
        
        // bullet
        addOptionalSubnode(bulletNode)
        
        // text
        addSubnode(textNode)
        textNode.userInteractionEnabled = true
        textNode.linkAttributeNames = [ linkAttributeName ];
    }
    
    // optional initializer that returns nil if label is nil. this makes it more convenient to initialize an optional labelNode in containing nodes
    convenience init?(optionalLabel: Label?) {
        guard let label = optionalLabel else { return nil }
        self.init(label: label)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nodes: [ASLayoutable?] = [bulletNode, textNode]
        let stackSpec = ASStackLayoutSpec(direction: .Horizontal, spacing: 10, alignItems: .Center, optionalChildren: nodes)
        return ASInsetLayoutSpec(insets: label.insets, child: stackSpec)

    }
}
