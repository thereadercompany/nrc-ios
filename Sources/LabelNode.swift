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
    let textNode = ASTextNode()
    let bulletNode: ASDisplayNode?
    
    let label: Label
    
    init(label: Label) {
        self.label = label
        bulletNode = BulletNode(bullet: label.bullet)
        
        super.init()
        
        backgroundColor = label.backgroundColor
        cornerRadius = label.corners?.radius ?? 0
        borderColor = label.border?.color.CGColor
        borderWidth = label.border?.width ?? 0
        
        // bullet
        if let bulletNode = bulletNode {
            addSubnode(bulletNode)
        }
        
        // text
        addSubnode(self.textNode)
        textNode.attributedText = label.text
        textNode.userInteractionEnabled = true
        textNode.linkAttributeNames = [ linkAttributeName ];
    }
    
    // optional initializer that returns nil if label is nil. this makes it more convenient to initialize an optional labelNode in containing nodes
    convenience init?(label: Label?) {
        guard let label = label else { return nil }
        self.init(label: label)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let optionalNodes: [ASLayoutable?] = [bulletNode, textNode]
        let nodes = optionalNodes.flatMap { $0 }
        let stackSpec = ASStackLayoutSpec(direction: .Horizontal, spacing: 10, justifyContent: .Start, alignItems: .Center, children: nodes)
        return ASInsetLayoutSpec(insets: label.insets, child: stackSpec)

    }
}
