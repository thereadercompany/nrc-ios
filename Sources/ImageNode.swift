//
//  ImageNode.swift
//  NRC
//
//  Created by Taco Vollmer on 13/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core
import AsyncDisplayKit

/**
 Content for the ImageNode
 */
final class ImageNodeContent: Content {
    let image: Image
    let caption: NSAttributedString?
    let credit: NSAttributedString?
    let gradient: LinearGradient?
    let action: Action?
    
    init(image: Image,
         caption: NSAttributedString? = nil,
         credit: NSAttributedString? = nil,
         gradient: LinearGradient? = nil,
         action: Action? = nil,
         backgroundColor: UIColor,
         padding: UIEdgeInsets = UIEdgeInsets()
        ) {
        self.image = image
        self.caption = caption
        self.credit = credit
        self.gradient = gradient
        self.action = action
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

/**
 Node for rendering an image
 */
final class ImageNode: ContentNode<ImageNodeContent> {
    let imageNode: ASNetworkImageNode
    let gradientNode: ASDisplayNode?
    let captionNode: ASTextNode?
    let creditNode: ASTextNode?
    
    required init(content: ImageNodeContent) {
        imageNode = ASNetworkImageNode(image: content.image)
        gradientNode = ASDisplayNode(optionalGradient: content.gradient)
        captionNode = ASTextNode(optionalText: content.caption)
        creditNode = ASTextNode(optionalText: content.credit)
        
        super.init(content: content)
        imageNode.URL = content.image.URL
        addSubnode(imageNode)
        
        addOptionalSubnode(gradientNode)
        addOptionalSubnode(captionNode)
        addOptionalSubnode(creditNode)
    }
    
    /* 
     optional initializer that returns nil if content is nil. this makes it more convenient to initialize an optional imageNode in containing nodes.
    "content:" as argument name seems to confuse the type checker
     */
    convenience init?(optionalContent: ImageNodeContent?) {
        guard let content = optionalContent else { return nil }
        self.init(content: content)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = width / content.image.aspectRatio
        let size = CGSize(width: width, height: height)
        self.imageNode.preferredFrameSize = size
        
        var imageNode: ASLayoutable = self.imageNode
        if let gradientNode = gradientNode {
            imageNode = ASOverlayLayoutSpec(child: self.imageNode, overlay: gradientNode)
        }
        
        var contentNodes: [ASLayoutable] = [imageNode]
        if captionNode != nil || creditNode != nil {
            let captionStack = ASStackLayoutSpec(direction: .Vertical, spacing:  5, optionalChildren: [captionNode, creditNode])
            let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            let captionInsetSpec = ASInsetLayoutSpec(insets: insets, child: captionStack)
            contentNodes.append(captionInsetSpec)
        }
        
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: contentNodes)
        return ASInsetLayoutSpec(insets: content.padding, child: stackSpec)
    }
    
    override func handleTap() {
        if let actionHandler = actionHandler, action = content.action {
            actionHandler.handleAction(action, sender: self)
        }
    }
}
