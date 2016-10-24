//
//  EnhancedBannerNode.swift
//  NRC
//
//  Created by Taco Vollmer on 27/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core
import AsyncDisplayKit

//MARK: - Content
/**
 Content for the EnhancedBannerNode
 */
final class EnhancedBannerNodeContent: Content {
    let title: NSAttributedString?
    let subtitle: NSAttributedString?
    let image: ImageNodeContent?
    let buttons: [Button]?
    let action: Action?
    let height: CGFloat?
    
    init(title: NSAttributedString?,
         subtitle: NSAttributedString?,
         image: ImageNodeContent?,
         buttons: [Button]?,
         action: Action?,
         height: CGFloat?,
         backgroundColor: UIColor,
         padding: UIEdgeInsets) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.buttons = buttons
        self.action = action
        self.height = height
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

//MARK: - Node
/**
 Node for rendering an enhanced banner with title and optional background image, subtitle and/or buttons
 */
final class EnhancedBannerNode : ContentNode<EnhancedBannerNodeContent> {
    let titleNode: ASTextNode?
    let subtitleNode: ASTextNode?
    let buttonNodes: [ButtonNode]?
    let imageNode: ImageNode?
    
    let gradientNode = ASDisplayNode(layerBlock: {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.5)
        return gradientLayer
    })
    
    // pass actionHandler on to button nodes
    override weak var actionHandler: ActionHandler? {
        didSet {
            buttonNodes?.forEach { $0.actionHandler = actionHandler }
        }
    }
    
    //MARK: - Init
    required init(content: EnhancedBannerNodeContent) {
        imageNode = ImageNode(optionalContent: content.image)
        titleNode = ASTextNode(optionalText: content.title)
        subtitleNode = ASTextNode(optionalText: content.subtitle)
        buttonNodes = content.buttons?.map(ButtonNode.init)
        
        super.init(content: content)
        
        if let imageNode = addOptionalSubnode(imageNode) {
            imageNode.userInteractionEnabled = false
        }
        
        addOptionalSubnode(titleNode)
        addOptionalSubnode(subtitleNode)
        
        buttonNodes?.forEach(addSubnode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var buttonStack: ASLayoutable? = nil
        if let buttonNodes = buttonNodes {
            buttonStack = ASStackLayoutSpec(direction: .Vertical, spacing: 6, justifyContent: .Start, alignItems: .Center, children: buttonNodes)
        }
        
        let nodes: [ASLayoutable?] = [titleNode, subtitleNode, buttonStack]
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 30, justifyContent: .Center, alignItems: .Center, optionalChildren: nodes)
        
        let paddedContent = ASInsetLayoutSpec(insets: content.padding, child: stackSpec)
        
        var contentSpec: ASLayoutable = paddedContent
        if let imageNode = imageNode {
            contentSpec = ASBackgroundLayoutSpec(child: paddedContent, background: imageNode)
        }
        
        // set size range to stretch the content to the max width
        let minSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Points, value: content.height ?? 0)
        )
        let maxSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Percent, value: 1)
        )
        
        contentSpec.sizeRange = ASRelativeSizeRange(min: minSize, max: maxSize)
        return ASStaticLayoutSpec(children: [contentSpec])
    }
    
    //MARK: - Interaction
    override func handleTap() {
        if let action = content.action, actionHandler = actionHandler {
            actionHandler.handleAction(action, sender: self)
        }
    }
}
