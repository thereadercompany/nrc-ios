//
//  ArticleHeaderNode.swift
//  NRC
//
//  Created by Taco Vollmer on 24/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

final class ArticleHeaderNodeContent: Content {
    let image: Image?
    let title: NSAttributedString
    let parallaxFactor: CGFloat
    
    init(image: Image?, title: NSAttributedString, parallaxFactor: CGFloat = 0.4, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.image = image
        self.title = title
        self.parallaxFactor = parallaxFactor
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

final class ArticleHeaderNode: ContentNode<ArticleHeaderNodeContent>, VisibilityObserver {
    let imageNode: ASNetworkImageNode?
    let titleNode: ASTextNode
    
    // textNode will not fill to full width. This node creates a full width background behind the text so parallax will work as intended
    private let titleBackgroundNode = ASDisplayNode()
    
    //MARK: - Init
    required init(content: ArticleHeaderNodeContent) {
        imageNode = ASNetworkImageNode(optionalImage: content.image)
        titleNode = ASTextNode(text: content.title)
        super.init(content: content)
        
        // add image behind title for parallax effect
        addOptionalSubnode(imageNode)
        
        titleBackgroundNode.backgroundColor = content.backgroundColor
        addSubnode(titleBackgroundNode)
        addSubnode(titleNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // image
        var imageSpec: ASLayoutable? = nil
        if let imageNode = imageNode, aspectRatio = content.image?.aspectRatio {
            imageSpec = ASRatioLayoutSpec(ratio: 1 / aspectRatio , child: imageNode)
        }
        
        // title
        let titleSpec = ASInsetLayoutSpec(insets: content.padding, child: titleNode)
        let titleBackgroundSpec = ASBackgroundLayoutSpec(child: titleSpec, background: titleBackgroundNode)
        
        // fix title background node width
        let minSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Points, value: 0)
        )
        let maxSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Percent, value: 1)
        )
        titleBackgroundSpec.sizeRange = ASRelativeSizeRange(min: minSize, max: maxSize)
        let fixedWidthSpec = ASStaticLayoutSpec(children: [titleBackgroundSpec])
        
        // stack
        let children: [ASLayoutable?] = [imageSpec, fixedWidthSpec]
        return ASStackLayoutSpec(direction: .Vertical, optionalChildren: children)
    }
    
    //MARK: - visibilityObserver
    func visibilityChanged(centerOffset offset: CGPoint, viewPortSize: CGSize) {
        guard let imageNode = imageNode else { return }
        
        let zeroOffset = viewPortSize.rect.center - bounds.center
        let relativeOffset = zeroOffset + offset
        
        if relativeOffset.y <= 0 {
        // parallax when scroll in to content
            supernode?.clipsToBounds = true
            clipsToBounds = true
            
            let parallax = -content.parallaxFactor * relativeOffset.y
            imageNode.transform = CATransform3DMakeTranslation(0, parallax, 0)
        }
        // stretch when pulling down on top
        else {
            supernode?.clipsToBounds = false
            clipsToBounds = false
            
            let scale = (relativeOffset.y / imageNode.bounds.height) + 1
            let scaleTransform = CATransform3DMakeScale(scale, scale, 1)
            
            // scale scales 0.5 on each side compensate here for the bottom half so bottom stays aligned
            let translation = -0.5 * relativeOffset.y
            let translationTransform = CATransform3DMakeTranslation(0, translation, 0)
            
            let transform = CATransform3DConcat(scaleTransform, translationTransform)
            imageNode.transform = transform
        }
    }
}