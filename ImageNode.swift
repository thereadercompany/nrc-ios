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

struct Image {
    let URL : (size: CGSize) -> NSURL
    let aspectRatio: CGFloat
}

class ImageNodeContent: Content {
    let image: Image
    let caption: NSAttributedString?
    let credit: NSAttributedString?
    
    init(image: Image,
         caption: NSAttributedString?,
         credit: NSAttributedString?,
         backgroundColor: UIColor,
         padding: UIEdgeInsets = UIEdgeInsets()
        ) {
        self.image = image
        self.caption = caption
        self.credit = credit
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class ImageNode<C: ImageNodeContent>: ContentNode<C> {
    let imageNode = ASNetworkImageNode()
    let captionNode: ASTextNode?
    let creditNode: ASTextNode?
    
    required init(content: C) {
        captionNode = ASTextNode(text: content.caption)
        creditNode = ASTextNode(text: content.credit)
        
        super.init(content: content)
        
        addSubnode(imageNode)
        
        if let captionNode = captionNode {
            addSubnode(captionNode)
        }
        
        if let creditNode = creditNode {
            addSubnode(creditNode)
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let height = width / content.image.aspectRatio
        let imageSize = CGSize(width: width, height: height)
        updateImageSize(imageSize)
        
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
    
    private func updateImageSize(size: CGSize) {
        imageNode.preferredFrameSize = size
        imageNode.URL = content.image.URL(size: size)
    }
}
