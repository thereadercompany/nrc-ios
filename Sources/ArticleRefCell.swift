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

class ArticleRefCell: Core.ArticleRefCell {
    let titleNode = ASTextNode()
    let lineNode = ASDisplayNode()
    var contentPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: TimelineStyles.contentInset, bottom: 20, right: TimelineStyles.contentInset)
    }
    
    let lineHeight: CGFloat

    //MARK: - initialization
    init(articleRef: ArticleRefBlock, dataController: BlockContextDataController, cellFactory: CellFactory, styles: ArticleRefCellStyles) {
        lineHeight = styles.lineHeight
        super.init(articleRef: articleRef, dataController: dataController, cellFactory: cellFactory, styles: styles)
        addSubnode(titleNode)
        
        if shouldRenderLineNode {
            addSubnode(lineNode)
        }
        
        titleNode.flexShrink = true

        let attrs = StringAttributes(font: styles.titleFont, foregroundColor: styles.titleFontColor, lineSpacing: 2, hyphenationFactor: 0.8)
        titleNode.attributedString = NSMutableAttributedString(string: articleRef.headline, attributes: attrs.dictionary)
        
        imageNode.clipsToBounds = true
    }
    
    override func didLoad() {
        super.didLoad()
        lineNode.backgroundColor = articleRef.lineColor
    }

    override func imageRect(constrainedRect: CGRect) -> CGRect {
        //let rect = constrainedRect.horizontalInsetsBy(highlightStyles.decorationPadding)
        return imageNode.frame
    }

    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let width = constrainedSize.max.width
        let titleLayoutSpec = ASInsetLayoutSpec(insets: contentPadding, child: titleNode)
        let content: [ASLayoutable] = [titleLayoutSpec, lineNode]
        lineNode.preferredFrameSize = CGSize(width: width, height: lineHeight)

        let contentLayoutSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: content)
        return contentLayoutSpec
//        return self.decorationLayoutSpec(contentLayoutSpec: contentLayoutSpec)
    }
    
    var shouldRenderLineNode: Bool {
        switch articleRef.decoration {
        case .Top, .Middle: return true
        default: return false
        }
    }
}

class NormalArticleRefCell: ArticleRefCell {
    private let imageSize = CGSize(width: 92, height: 56)
    private let imageTitleSpacing: CGFloat = 10
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        // layout content
        var content: [ASLayoutable] = [titleNode]
        if mediaStyles.shouldRenderImage {
            imageNode.preferredFrameSize = imageSize
            imageNode.spacingAfter = imageTitleSpacing
            content.insert(imageNode, atIndex: 0)
        }
        let contentStack = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: .Start, alignItems: .Center, children: content)
        
        // add contentpadding
        let paddedContentStack = ASInsetLayoutSpec(insets: contentPadding, child: contentStack)
        
        // add line
        lineNode.preferredFrameSize = CGSize(width: width, height: lineHeight)
        let cellItems: [ASLayoutable] = [paddedContentStack, lineNode]
        let contentLayoutSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: cellItems)
        return contentLayoutSpec
        //return decorationLayoutSpec(contentLayoutSpec: contentLayoutSpec)
    }
}

class LargeArticleRefCell: ArticleRefCell {
    private let imageRatio: CGFloat = 5/3
    private let imageTitleSpacing: CGFloat = 15

    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        let contentPadding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 15, right: TimelineStyles.contentInset)
        let titleInsets = UIEdgeInsets(top: 0, left: contentPadding.left, bottom: contentPadding.bottom, right: contentPadding.right)
        let titleInsetsSpec = ASInsetLayoutSpec(insets: titleInsets, child: titleNode)

        // setup line
        lineNode.preferredFrameSize = CGSize(width: width, height: lineHeight)

        var content: [ASLayoutable] = [titleInsetsSpec, lineNode]
        if mediaStyles.shouldRenderImage {
            imageNode.spacingAfter = imageTitleSpacing
            let imageWidth = width
            let imageHeight = imageWidth / imageRatio
            let imageSize = CGSize(width: imageWidth, height: imageHeight)
            imageNode.preferredFrameSize = imageSize
            content.insert(imageNode, atIndex: 0)
        }

        let contentLayoutSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: content)
        return contentLayoutSpec
//        return decorationLayoutSpec(contentLayoutSpec: contentLayoutSpec)
    }
}

class ExtraLargeArticleRefCell: ArticleRefCell {
    let labelNode = LabelNode()
    let richTextNode = ASTextNode()
    let gradientNode: ASDisplayNode
    
    override var contentPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
    }
    
    // Cell
    override init(articleRef: ArticleRefBlock, dataController: BlockContextDataController, cellFactory: CellFactory, styles: ArticleRefCellStyles) {
        gradientNode = ASDisplayNode(layerBlock: {
            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [UIColor.clearColor().CGColor,UIColor.blackColor().CGColor]
//            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.7)
            return gradientLayer
        })
        
        super.init(articleRef: articleRef, dataController: dataController, cellFactory: cellFactory, styles: styles)
        addSubnode(gradientNode)
        
        if let label = articleRef.label {
            addSubnode(labelNode)
            let attributes = StringAttributes(font: Fonts.labelFont.fallbackWithSize(10), foregroundColor: styles.labelTextColor, lineSpacing: 0).dictionary
            labelNode.text = NSAttributedString(string: label, attributes: attributes)
            labelNode.applyStyle(textInsets: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10), backgroundColor: styles.labelBackgroundColor, cornerRadius: 10)
        }

        if let richText = articleRef.abstract {
            addSubnode(richTextNode)
            let attributes = StringAttributes(font: Fonts.lightFont.fallbackWithSize(20), foregroundColor: styles.abstractFontColor, lineSpacing: 0).dictionary
            richTextNode.attributedString = NSAttributedString(string: richText, attributes: attributes)
        }
        
        backgroundColor = UIColor.whiteColor()
        imageNode = ImageNode()
    }
    
    override func didLoad() {
        super.didLoad()
        let shadowColor = UIColor.blackColor().CGColor
        let shadowOffset = CGSize(width: 1, height: 0)
        let shadowOpacity: CGFloat = 1
        let shadowRadius: CGFloat = 3
        titleNode.shadowColor = shadowColor
        titleNode.shadowOffset = shadowOffset
        titleNode.shadowOpacity = shadowOpacity
        titleNode.shadowRadius = shadowRadius
        
        if let _ = articleRef.abstract {
            richTextNode.shadowColor = shadowColor
            richTextNode.shadowOffset = shadowOffset
            richTextNode.shadowOpacity = shadowOpacity
            richTextNode.shadowRadius = shadowRadius
        }
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if shouldRenderLineNode {
            lineNode.preferredFrameSize = CGSize(width: constrainedSize.max.width, height: 1)
        }
        
        var textNodes: [ASLayoutable] = []
        
        if let _ = articleRef.label {
            textNodes.append(labelNode)
            labelNode.spacingAfter = 14
        }
        
        textNodes.append(titleNode)
        titleNode.spacingAfter = 10
        if let _ = articleRef.abstract {
            textNodes.append(richTextNode)
        }
        textNodes.last?.spacingAfter = 0
        for node in textNodes {
            node.flexShrink = true
        }
        
        let textContent = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: textNodes)
        let paddedContent = ASInsetLayoutSpec(insets: contentPadding, child: textContent)
        let gradientContent = ASBackgroundLayoutSpec(child: paddedContent, background: gradientNode)
        gradientContent.spacingBefore = 250
        
        let card = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Stretch, children: [gradientContent,lineNode])
        let imageCard = ASBackgroundLayoutSpec(child: card, background: imageNode)
        
        return imageCard
//        let decorationPadding = ASInsetLayoutSpec(insets: articleRef.decorationPadding, child: imageCard)

//        let combined = ASBackgroundLayoutSpec(child: decorationPadding, background: decorationNode)
//        return combined
    }

}

