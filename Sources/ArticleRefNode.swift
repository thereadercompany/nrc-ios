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
        return content.line?.size.height ?? 0
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
        addOptionalSubnode(labelNode)
        
        // line
        if let line = content.line {
            addSubnode(lineNode)
            lineNode.backgroundColor = line.color
        }
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        fatalError("Override layoutSpecThatFits in concrete subclasses")
    }
    
    //MARK: - Tap
    override func handleTap() {
        let action: Action
        if let url = content.url {
            action = .OpenURL(url)
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
        let verticalNodes: [ASLayoutable?] = [labelNode, titleNode]
        let verticalStackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 10, optionalChildren: verticalNodes)
        verticalStackSpec.flexShrink = true
        
        // horizontal
        let horizontalStackNodes: [ASLayoutable?] = [imageNode, verticalStackSpec]
        let horizontalStack = ASStackLayoutSpec(direction: .Horizontal, alignItems: .BaselineFirst, optionalChildren: horizontalStackNodes)
        
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
        let stackNodes: [ASLayoutable?] = [labelNode, titleNode]
        let stackSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 15, optionalChildren: stackNodes)
        
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
    let gradientNode = ASDisplayNode(gradient: LinearGradient(colors: [.clearColor(), .blackColor()], end: CGPoint(x: 0.5, y: 1.7)))
    
    private let imageRatio: CGFloat = {
        let heightMultiplier: CGFloat = Window.vval([Screen.vXS:1,Screen.vS:0.9,Screen.vM:0.8,Screen.vL:0.7])
        return (Screen.height * heightMultiplier) / Screen.width
    }()
    
    // Cell
    required init(content: ArticleRefNodeContent) {
        abstractNode = ASTextNode(text: content.abstract)
        super.init(content: content)
        insertSubnode(gradientNode, belowSubnode: titleNode)
        
        let shadowColor = UIColor.blackColor().CGColor
        let shadowOffset = CGSize(width: 1, height: 0)
        let shadowOpacity: CGFloat = 1
        let shadowRadius: CGFloat = 3
        titleNode.shadowColor = shadowColor
        titleNode.shadowOffset = shadowOffset
        titleNode.shadowOpacity = shadowOpacity
        titleNode.shadowRadius = shadowRadius
        
        if let abstractNode = abstractNode {
            addSubnode(abstractNode)
            abstractNode.shadowColor = shadowColor
            abstractNode.shadowOffset = shadowOffset
            abstractNode.shadowOpacity = shadowOpacity
            abstractNode.shadowRadius = shadowRadius
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageSpec = ASRatioLayoutSpec(ratio: imageRatio, child: imageNode)        
        lineNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: lineThickness)
        
        let textNodes: [ASLayoutable?] = [labelNode, titleNode, abstractNode]
        let textContentSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 10, optionalChildren: textNodes)
        let paddedContentSpec = ASInsetLayoutSpec(insets: content.padding, child: textContentSpec)
        let gradientContentSpec = ASBackgroundLayoutSpec(child: paddedContentSpec, background: gradientNode)

        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        let card = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .End, alignItems: .Stretch, children: [spacer, gradientContentSpec ,lineNode])
        card.flexGrow = true
        return ASOverlayLayoutSpec(child: imageSpec, overlay: card)
    }
}
