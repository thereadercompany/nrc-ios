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

class HeadlineCell: ArticleRefCell {
    let titleNode = ASTextNode()
    let lineNode = ASDisplayNode()
    var lineHeight: CGFloat = 1
    var contentPadding: UIEdgeInsets = UIEdgeInsets(top: 20, left: TimelineStyles.contentInset, bottom: 20, right: TimelineStyles.contentInset)
//    var decorationPadding: UIEdgeInsets
//    var decorationNode = ASDisplayNode()


    //MARK: - initialization
    override init(articleRef: ArticleRefBlock, dataController: BlockContextDataController, cellFactory: CellFactory, styles: ArticleRefCellStyles) {
        super.init(articleRef: articleRef, dataController: dataController, cellFactory: cellFactory, styles: styles)

        //addSubnode(decorationNode)
        addSubnode(lineNode)
        addSubnode(titleNode)
        titleNode.flexShrink = true

        let attrs = StringAttributes(font: Fonts.mediumFont.fallbackWithSize(19), foregroundColor: Colors.defaultFontColor, lineSpacing: 2, hyphenationFactor: 0.8)
        titleNode.attributedString = NSMutableAttributedString(string: articleRef.headline, attributes:attrs.dictionary)
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

    override func fetchData() {
        super.fetchData()
        preloadImage()
    }

    func preloadImage() {
        let media = articleRef.media
        if media.identifier.isEmpty { return }
        let URL = media.URL(forFormat: .Large)
        ImageController.shared.loadImageWithURL(URL) { [weak self] (image, error) -> Void in
            if image != nil {
                self?.image = image
            }
        }
    }

//    private func decorationLayoutSpec(contentLayoutSpec content: ASLayoutable) -> ASLayoutSpec {
//        let decorationPaddingSpec = ASInsetLayoutSpec(insets: decorationPadding, child: content)
//        return ASBackgroundLayoutSpec(child: decorationPaddingSpec, background: decorationNode)
//    }

}
//
//class LargeHeadlineCell: HeadlineCell {
//    private let imageRatio: CGFloat = 5/3
//    private let imageTitleSpacing: CGFloat = 15
//
//    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
//        let width = constrainedSize.max.width
//        let contentPadding = articleRef.contentPadding
//        let titleInsets = UIEdgeInsets(top: 0, left: contentPadding.left, bottom: contentPadding.bottom, right: contentPadding.right)
//        let titleInsetsSpec = ASInsetLayoutSpec(insets: titleInsets, child: titleNode)
//
//        // setup line
//        lineNode.preferredFrameSize = CGSize(width: width, height: lineHeight)
//
//        var content: [ASLayoutable] = [titleInsetsSpec, lineNode]
//        if mediaNode.shouldRenderImage {
//            mediaNode.spacingAfter = imageTitleSpacing
//            let imageWidth = width
//            let imageHeight = imageWidth / imageRatio
//            let imageSize = CGSize(width: imageWidth, height: imageHeight)
//            mediaNode.preferredFrameSize = imageSize
//            mediaNode.mediaSize = MediaSize(size: imageSize)
//            content.insert(mediaNode, atIndex: 0)
//        }
//
//        let contentLayoutSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .Start, alignItems: .Start, children: content)
//        return decorationLayoutSpec(contentLayoutSpec: contentLayoutSpec)
//    }
//}
//
class NormalHeadlineCell: HeadlineCell {
    private let imageSize = CGSize(width: 92, height: 56)
    private let imageTitleSpacing: CGFloat = 10

    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width

        // layout content
        var content: [ASLayoutable] = [titleNode]
        if mediaStyles.shouldRenderImage {
            let mediaLayout = ASOverlayLayoutSpec(child: imageNode, overlay: placeholderNode)
            imageNode.preferredFrameSize = imageSize
            placeholderNode.preferredFrameSize = imageSize
            mediaLayout.spacingAfter = imageTitleSpacing
            content.insert(mediaLayout, atIndex: 0)
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
