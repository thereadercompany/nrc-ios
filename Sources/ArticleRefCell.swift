//
//  HeadlineCell.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 17/08/16.
//  Copyright © 2016 The Reader Company. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

extension NSAttributedString {
    convenience init (string: String, attributes: StringAttributes) {
        self.init(string: string, attributes: attributes.dictionary)
    }
}

extension ASTextNode {
    convenience init?(text: NSAttributedString?) {
        guard let text = text else { return nil }
        self.init()
        self.attributedText = text
    }
}

extension ASNetworkImageNode {
    convenience init?(url: NSURL?) {
        guard let url = url else { return nil }
        self.init()
        self.URL = url
    }
}

struct LineModel {
    let color: UIColor
    let thickness: CGFloat
}

class ArticleRefNodeContent: CellContent {
    let articleIdentifier: String
    let url: NSURL?
    
    let title: NSAttributedString
    let line: LineModel?
    
    var abstract: NSAttributedString? = nil
    var image: NSURL? = nil
    var label: LabelModel? = nil
    
    init(articleIdentifier: String, url: NSURL?, title: NSAttributedString, line: LineModel?) {
        self.articleIdentifier = articleIdentifier
        self.url = url
        self.title = title
        self.line = line
    }
}

class ArticleRefNode: ContentNode<ArticleRefNodeContent> {
    let titleNode = ASTextNode()
    let lineNode = ASDisplayNode()
    let imageNode: ASNetworkImageNode?
    
    var lineThickness: CGFloat {
        return model.line?.thickness ?? 0
    }
    
    //MARK: - initialization
    required init(model: ArticleRefNodeContent) {
        imageNode = ASNetworkImageNode(url: model.image)
        super.init(model: model)
        
        // title
        addSubnode(titleNode)
        titleNode.flexShrink = true
        titleNode.attributedText = model.title
        
        // image
        if let imageNode = imageNode {
            addSubnode(imageNode)
            imageNode.clipsToBounds = true
        }
        
        // line
        if let line = model.line {
            addSubnode(lineNode)
            lineNode.backgroundColor = line.color
        }
    }
    
    override var action: CellAction? {
        if let url = model.url {
            return .OpenURL(url)
        }
        
        return .ShowArticle(identifier: model.articleIdentifier, image: imageNode?.image)
    }
    
    override func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let titleLayoutSpec = ASInsetLayoutSpec(insets: model.contentPadding, child: titleNode)
        let content: [ASLayoutable] = [titleLayoutSpec, lineNode]
        lineNode.preferredFrameSize = CGSize(width: width, height: lineThickness)
        
        return ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: content)
    }
}

class NormalArticleRefNode: ArticleRefNode {
    private let imageSize = CGSize(width: 92, height: 56)
    private let imageTitleSpacing: CGFloat = 10
    
    override func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        // layout content
        var content: [ASLayoutable] = [titleNode]
        if let imageNode = imageNode {
            imageNode.preferredFrameSize = imageSize
            imageNode.spacingAfter = imageTitleSpacing
            content.insert(imageNode, atIndex: 0)
        }
        let contentStack = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: .Start, alignItems: .Center, children: content)
        
        // add contentpadding
        let paddedContentStack = ASInsetLayoutSpec(insets: model.contentPadding, child: contentStack)
        
        // add line
        lineNode.preferredFrameSize = CGSize(width: width, height: lineThickness)
        let cellItems: [ASLayoutable] = [paddedContentStack, lineNode]
        return ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: cellItems)
    }
}

class LargeArticleRefNode: ArticleRefNode {
    private let imageRatio: CGFloat = 5/3
    private let imageTitleSpacing: CGFloat = 15
    
    override func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let contentPadding = model.contentPadding
        let titleInsets = UIEdgeInsets(top: 0, left: contentPadding.left, bottom: contentPadding.bottom, right: contentPadding.right)
        let titleInsetsSpec = ASInsetLayoutSpec(insets: titleInsets, child: titleNode)
        
        // setup line
        lineNode.preferredFrameSize = CGSize(width: width, height: lineThickness)
        
        var content: [ASLayoutable] = [titleInsetsSpec, lineNode]
        if let imageNode = imageNode {
            imageNode.spacingAfter = imageTitleSpacing
            let imageWidth = width
            let imageHeight = imageWidth / imageRatio
            let imageSize = CGSize(width: imageWidth, height: imageHeight)
            imageNode.preferredFrameSize = imageSize
            content.insert(imageNode, atIndex: 0)
        }
        
        return ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: content)
    }
}

class ExtraLargeArticleRefNode: ArticleRefNode {
    let labelNode: LabelNode?
    let abstractNode: ASTextNode?
    let gradientNode = ASDisplayNode(layerBlock: {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.7)
        return gradientLayer
    })
    
    // Cell
    required init(model: ArticleRefNodeContent) {
        labelNode = LabelNode(model: model.label)
        abstractNode = ASTextNode(text: model.abstract)
        super.init(model: model)
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
        
        backgroundColor = UIColor.whiteColor()
    }
    
    override func didLoad() {
        super.didLoad()
        //TEST: moved shadow to init is it rendered?
    }
    
    override func contentLayoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        lineNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: lineThickness)
        
        var textNodes: [ASLayoutable] = []
        if let labelNode = labelNode {
            textNodes.append(labelNode)
            labelNode.spacingAfter = 14
        }
        
        textNodes.append(titleNode)
        titleNode.spacingAfter = 10
        if let abstractNode = abstractNode {
            textNodes.append(abstractNode)
        }
        textNodes.last?.spacingAfter = 0
        for node in textNodes {
            node.flexShrink = true
        }
        
        let textContent = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: textNodes)
        let paddedContent = ASInsetLayoutSpec(insets: model.contentPadding, child: textContent)
        let gradientContent = ASBackgroundLayoutSpec(child: paddedContent, background: gradientNode)
        gradientContent.spacingBefore = 250
        
        let card = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Stretch, children: [gradientContent,lineNode])
        return ASBackgroundLayoutSpec(child: card, background: imageNode)
        
    }
}

