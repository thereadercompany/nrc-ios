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
    let spacing: CGFloat
    let height: CGFloat?
    
    init(title: NSAttributedString?,
         subtitle: NSAttributedString?,
         image: ImageNodeContent?,
         buttons: [Button]?,
         action: Action?,
         spacing: CGFloat,
         height: CGFloat?,
         backgroundColor: UIColor,
         padding: UIEdgeInsets) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.buttons = buttons
        self.action = action
        self.spacing = spacing
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
    
    required init(content: EnhancedBannerNodeContent) {
        imageNode = ImageNode(optionalContent: content.image)
        titleNode = ASTextNode(text: content.title)
        subtitleNode = ASTextNode(text: content.subtitle)
        buttonNodes = content.buttons?.map(ButtonNode.init)
        
        super.init(content: content)
        
        if let imageNode = imageNode {
            addSubnode(imageNode)
        }
        
        if let titleNode = titleNode {
            addSubnode(titleNode)
        }
        
        if let subtitleNode = subtitleNode {
            addSubnode(subtitleNode)
        }
        
        buttonNodes?.forEach { buttonNode in
            addSubnode(buttonNode)
            buttonNode.actionHandler = actionHandler
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var buttonStack: ASLayoutable? = nil
        if let buttonNodes = buttonNodes {
            buttonStack = ASStackLayoutSpec(direction: .Vertical, spacing: 6, justifyContent: .Start, alignItems: .Center, children: buttonNodes)
        }
        
        let optionalNodes: [ASLayoutable?] = [titleNode, subtitleNode, buttonStack]
        let nodes = optionalNodes.flatMap { $0 } // remove .None
        
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: content.spacing, justifyContent: .Center, alignItems: .Center, children: nodes)
        
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
