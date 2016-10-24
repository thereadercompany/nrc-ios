//
//  EnhancedBannerButtonNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/**
 Model for rendering a button that can perform an action and is optionally tracked
 **/
struct Button {
    let title: NSAttributedString
    let size: CGSize
    let border: Border?
    let cornerInfo: CornerInfo
    let backgroundColor: UIColor
    let action: Action
    let tracker: Tracker?
}

/** Node for rendering a `Button` */
class ButtonNode : ASControlNode, ActionSender {
    private let button: Button
    let textNode: ASTextNode
    
    weak var actionHandler: ActionHandler?
    
    init(button: Button) {
        self.button = button
        textNode = ASTextNode(text: button.title)
        super.init()
        
        addTarget(self, action: #selector(tapped), forControlEvents: .TouchUpInside)
        backgroundColor = button.backgroundColor
        
        addSubnode(textNode)
        userInteractionEnabled = true
    }
    
    @objc private func tapped() {
        button.tracker?.trackTap()
        actionHandler?.handleAction(button.action, sender: self)
    }
        
    override func didLoad() {
        super.didLoad()
        layer.cornerRadius = button.cornerInfo.radius
        if let border = button.border {
            layer.borderColor = border.color.CGColor
            layer.borderWidth = border.width
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: textNode)
        
        let size = ASRelativeSize(
            width: ASRelativeDimension(type: .Points, value: button.size.width),
            height: ASRelativeDimension(type: .Points, value: button.size.height)
        )
        centerSpec.sizeRange = ASRelativeSizeRange(min: size, max: size)
        
        return ASStaticLayoutSpec(children: [centerSpec])
    }
}
