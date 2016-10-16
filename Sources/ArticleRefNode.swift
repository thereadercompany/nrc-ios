//
//  ArticleRefNode.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 17/08/16.
//  Copyright © 2016 The Reader Company. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

//MARK: - Content
/** 
 Content for the ArticleRefNode
 */
final class ArticleRefNodeContent: Content {
    let articleIdentifier: String
    let url: NSURL?
    let title: NSAttributedString
    let abstract: NSAttributedString?
    let label: Label?
    let line: Line?
    let image: Image
    
    init(articleIdentifier: String,
         url: NSURL?,
         title: NSAttributedString,
         abstract: NSAttributedString?,
         label: Label?,
         line: Line?,
         image: Image,
         backgroundColor: UIColor,
         padding: UIEdgeInsets) {
        self.articleIdentifier = articleIdentifier
        self.url = url
        self.title = title
        self.abstract = abstract
        self.label = label
        self.line = line
        self.image = image
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

//MARK: - Abstract
/**
 Abstract node for rendering an ArticleRef. Subclass for specific layouting
 */
class ArticleRefNode: ContentNode<ArticleRefNodeContent> {
    let labelNode: LabelNode?
    let titleNode = ASTextNode()
    let lineNode = ASDisplayNode()
    let imageNode: ASNetworkImageNode
    
    var lineThickness: CGFloat {
        return content.line?.thickness ?? 0
    }
    
    //MARK: - initialization
    required init(content: ArticleRefNodeContent) {
        imageNode = ASNetworkImageNode(image: content.image)
        labelNode = LabelNode(label: content.label)
        super.init(content: content)
        
        // image
        addSubnode(imageNode)
        imageNode.clipsToBounds = true
        
        // title
        addSubnode(titleNode)
        titleNode.attributedText = content.title
        
        // label
        if let labelNode = labelNode {
            addSubnode(labelNode)
        }
        
        // line
        if let line = content.line {
            addSubnode(lineNode)
            lineNode.backgroundColor = line.color
        }
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        assertionFailure("ArticleRefNode is abstract. Override layoutSpecThatFits in concrete subclasses")
        return ASLayoutSpec()
    }
    
    //MARK: - Tap
    override func handleTap() {
        let action: Action
        if let url = content.url {
            action = .OpenURL(url, textLink: false)
        }
        else {
            action = .ShowArticle(identifier: content.articleIdentifier, imageNode: imageNode)
        }
        
        actionHandler?.handleAction(action, sender: self)
    }
}

//MARK: - Normal
/**
 Renders an ArticleRef with a thumb image (left), label and a title
 */
final class NormalArticleRefNode: ArticleRefNode {
    private let imageSize = CGSize(width: 92, height: 56)
    private let imageTitleSpacing: CGFloat = 10
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        titleNode.flexShrink = true
        imageNode.preferredFrameSize = imageSize
        imageNode.spacingAfter = imageTitleSpacing
        labelNode?.ascender = 3 // correction to perfectly align imagenode and label node using .BaselineFirst as alignment mode
        
        // vertical
        let optionalVerticalNodes: [ASLayoutable?] = [labelNode, titleNode]
        let verticalNodes = optionalVerticalNodes.flatMap { $0 }
        let verticalStackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 10, justifyContent: .Start, alignItems: .Start, children: verticalNodes)
        verticalStackSpec.flexShrink = true
        
        // horizontal
        let optionalHorizontalStackNodes: [ASLayoutable?] = [imageNode, verticalStackSpec]
        let horizontalStackNodes = optionalHorizontalStackNodes.flatMap { $0 }
        let horizontalStack = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: .Start, alignItems: .BaselineFirst, children: horizontalStackNodes)
        
        // content padding
        let paddedContentStack = ASInsetLayoutSpec(insets: content.padding, child: horizontalStack)
        
        // add line
        let width = constrainedSize.max.width
        lineNode.preferredFrameSize = CGSize(width: width, height: lineThickness)
        let cellItems: [ASLayoutable] = [paddedContentStack, lineNode]
        return ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: cellItems)
    }
}

//MARK: - Large
/**
 Renders an ArticleRef with an image, title and abstract
 */
final class LargeArticleRefNode: ArticleRefNode {
    private let imageRatio: CGFloat = 5/3
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // label and title
        let optionalStackNodes: [ASLayoutable?] = [labelNode, titleNode]
        let stackNodes = optionalStackNodes.flatMap { $0 } // filter .None
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 15, justifyContent: .Start, alignItems: .Start, children: stackNodes)
        
        // padding
        let insetSpec = ASInsetLayoutSpec(insets: content.padding, child: stackSpec)
        
        // line
        let width = constrainedSize.max.width
        lineNode.preferredFrameSize = CGSize(width: width, height: lineThickness)
        var contentNodes: [ASLayoutable] = [insetSpec, lineNode]
        
        // image
        let imageWidth = width
        let imageHeight = imageWidth / imageRatio
        let imageSize = CGSize(width: imageWidth, height: imageHeight)
        imageNode.preferredFrameSize = imageSize
        contentNodes.insert(imageNode, atIndex: 0)
        
        // stack
        return ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: contentNodes)
    }
}

//MARK: - Extra Large
/**
 Renders an ArticleRef with a background image and label, title and abstract - overlay
 */
final class ExtraLargeArticleRefNode: ArticleRefNode {
    let abstractNode: ASTextNode?
    let gradientNode = ASDisplayNode(gradient: LinearGradient(colors: [.clearColor(), .blackColor()], start: CGPoint(x: 0.5, y: 1.7)))
    
    // Cell
    required init(content: ArticleRefNodeContent) {
        abstractNode = ASTextNode(text: content.abstract)
        super.init(content: content)
        addSubnode(gradientNode)
        
        let shadowColor = UIColor.blackColor().CGColor
        let shadowOffset = CGSize(width: 1, height: 0)
        let shadowOpacity: CGFloat = 1
        let shadowRadius: CGFloat = 3
        titleNode.shadowColor = shadowColor
        titleNode.shadowOffset = shadowOffset
        titleNode.shadowOpacity = shadowOpacity
        titleNode.shadowRadius = shadowRadius
        
        if let labelNode = labelNode {
            addSubnode(labelNode)
        }
        
        if let abstractNode = abstractNode {
            addSubnode(abstractNode)
            abstractNode.shadowColor = shadowColor
            abstractNode.shadowOffset = shadowOffset
            abstractNode.shadowOpacity = shadowOpacity
            abstractNode.shadowRadius = shadowRadius
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        labelNode?.spacingAfter = 14
        titleNode.spacingAfter = 10
        lineNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: lineThickness)
        
        let optionalTextNodes: [ASLayoutable?] = [labelNode, titleNode, abstractNode]
        let textNodes: [ASLayoutable] = optionalTextNodes.flatMap { node in
            node?.flexShrink = true
            return node
        }
        textNodes.last?.spacingAfter = 0
        
        let textContentSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: textNodes)
        let paddedContentSpec = ASInsetLayoutSpec(insets: content.padding, child: textContentSpec)
        let gradientContentSpec = ASBackgroundLayoutSpec(child: paddedContentSpec, background: gradientNode)
        gradientContentSpec.spacingBefore = 250
        
        let card = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Stretch, children: [gradientContentSpec,lineNode])
        return ASBackgroundLayoutSpec(child: card, background: imageNode)
    }
}
