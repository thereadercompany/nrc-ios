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
    
    init(image: Image,
         caption: NSAttributedString? = nil,
         credit: NSAttributedString? = nil,
         gradient: LinearGradient? = nil,
         backgroundColor: UIColor,
         padding: UIEdgeInsets = UIEdgeInsets()
        ) {
        self.image = image
        self.caption = caption
        self.credit = credit
        self.gradient = gradient
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
        gradientNode = ASDisplayNode(gradient: content.gradient)
        captionNode = ASTextNode(text: content.caption)
        creditNode = ASTextNode(text: content.credit)
        
        super.init(content: content)
        imageNode.URL = content.image.URL
        addSubnode(imageNode)
        
        if let gradientNode = gradientNode {
            addSubnode(gradientNode)
        }
        
        if let captionNode = captionNode {
            addSubnode(captionNode)
        }
        
        if let creditNode = creditNode {
            addSubnode(creditNode)
        }
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
        
        let optionalCaptionNodes: [ASLayoutable?] = [captionNode, creditNode]
        let captionNodes = optionalCaptionNodes.flatMap { $0 }
        
        var contentNodes: [ASLayoutable] = [imageNode]
        if !captionNodes.isEmpty {
            let captionStack = ASStackLayoutSpec(direction: .Vertical, spacing:  5, justifyContent: .Start, alignItems: .Start, children: captionNodes)
            let insets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            let captionInsetSpec = ASInsetLayoutSpec(insets: insets, child: captionStack)
            contentNodes.append(captionInsetSpec)
        }
        
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: contentNodes)
        return ASInsetLayoutSpec(insets: content.padding, child: stackSpec)
    }
}
