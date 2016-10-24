//
//  TweetNode.swift
//  NRC
//
//  Created by Taco Vollmer on 10/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

final class TweetNodeContent: Content {
    let title: NSAttributedString?
    let text: NSAttributedString?
    let author: NSAttributedString
    let timestamp: NSAttributedString?
    let URL: NSURL?
    let icon: Image
    let photo: Image?
    
    init(title: NSAttributedString?,
         text: NSAttributedString?,
         author: NSAttributedString,
         timestamp: NSAttributedString?,
         URL: NSURL?,
         icon: Image,
         photo: Image?,
         backgroundColor: UIColor,
         padding: UIEdgeInsets) {
        self.title = title
        self.text = text
        self.author = author
        self.timestamp = timestamp
        self.URL = URL
        self.icon = icon
        self.photo = photo
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

final class TweetNode: ContentNode<TweetNodeContent>, ASTextNodeDelegate {
    static let iconSize = CGSize(width: 36, height: 36)
    
    let titleNode: ASTextNode?
    let textNode: ASTextNode?
    let authorNode: ASTextNode
    let timestampNode: ASTextNode?
    
    let iconNode = ASNetworkImageNode()
    let photoNode: ASNetworkImageNode?
    let logoNode = ASImageNode()
    
    required init(content: TweetNodeContent) {
        titleNode = ASTextNode(optionalText: content.title)
        textNode = ASTextNode(optionalText: content.text)
        authorNode = ASTextNode(text: content.author)
        timestampNode = ASTextNode(optionalText: content.timestamp)
        photoNode = ASNetworkImageNode(optionalImage: content.photo)
        
        super.init(content: content)
        
        //title
        if let titleNode = addOptionalSubnode(titleNode) {
            titleNode.maximumNumberOfLines = 1
        }
        
        //author
        authorNode.maximumNumberOfLines = 1
        addSubnode(authorNode)
        
        //text
        if let textNode = addOptionalSubnode(textNode) {
            textNode.delegate = self
            textNode.userInteractionEnabled = true
            textNode.linkAttributeNames = [linkAttributeName]
            textNode.passthroughNonlinkTouches = true
        }
        
        // icon
        iconNode.URL = content.icon.URL
        addSubnode(iconNode)
        
        // logo
        logoNode.image = UIImage(named: "twitter_logo")
        addSubnode(logoNode)
        
        // phote
        addOptionalSubnode(photoNode)
        
        // timestamp
        addOptionalSubnode(timestampNode)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        iconNode.preferredFrameSize = TweetNode.iconSize
        iconNode.spacingAfter = 9
        
        let headerNodes: [ASLayoutable?] = [titleNode, authorNode]
        let headerStackSpec = ASStackLayoutSpec(direction: .Vertical, optionalChildren: headerNodes)
        
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        let topStackSpec = ASStackLayoutSpec(direction: .Horizontal, spacing: 0, justifyContent: .Start, alignItems: .Center, children: [iconNode, headerStackSpec, spacer, logoNode])
        
        var tweetContentNodes: [ASLayoutable] = [topStackSpec]
        if let textNode = textNode {
            textNode.spacingBefore = 12
            tweetContentNodes.append(textNode)
        }
        if let timestampNode = timestampNode {
            timestampNode.spacingBefore = 3
            tweetContentNodes.append(timestampNode)
        }
        let contentSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Stretch, children: tweetContentNodes)
        
        let paddedContentSpec = ASInsetLayoutSpec(insets: content.padding, child: contentSpec)
        
        var children: [ASLayoutable] = [paddedContentSpec]
        if let photoNode = photoNode, photo = content.photo {
            let width = constrainedSize.max.width
            let height = width / photo.aspectRatio
            photoNode.preferredFrameSize = CGSize(width: width, height: height)
            children.insert(photoNode, atIndex: 0)
        }
        
        let cardSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: children)
        
        // stretch to max width and content size
        let minSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Percent, value: 0)
        )
        let maxSize = ASRelativeSize(
            width: ASRelativeDimension(type: .Percent, value: 1),
            height: ASRelativeDimension(type: .Percent, value: 1)
        )
        let sizeRange = ASRelativeSizeRange(min: minSize, max: maxSize)
        cardSpec.sizeRange = sizeRange
        
        return ASStaticLayoutSpec(children: [cardSpec])
    }
    
    override func handleTap() {
        if let URL = content.URL {
            actionHandler?.handleAction(.OpenURL(URL), sender: self)
        }
    }
        
    //MARK: - TextNodeDelegate
    func textNode(textNode: ASTextNode, tappedLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint, textRange: NSRange) {
        if let URL = value as? NSURL {
            actionHandler?.handleAction(.OpenURL(URL), sender: self)
        }
    }
    
    func textNode(textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint) -> Bool {
        return true
    }
    
}
