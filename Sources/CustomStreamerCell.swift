//
//  StreamerCell.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 27/08/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import Foundation
import BrightFutures
import AsyncDisplayKit
import Core

class CustomStreamerCellStyles: CellStyles {
    var attributedHeadline: NSAttributedString = NSAttributedString()
    var attributedSubHeadline: NSAttributedString?
    var shouldRenderSubHeadline: Bool = true
    var subHeadlineMarginTop: CGFloat = 0
    var subHeadlineMarginBottom: CGFloat = 0
    var headlineMarginBottom: CGFloat = 0
    var contentPadding: UIEdgeInsets = UIEdgeInsetsZero
    var iconSize: CGFloat = 40
    var iconMarginTop: CGFloat = 0
    var iconMarginLeft: CGFloat = 0
    var headlineMarginTop: CGFloat = 0
}

class CustomStreamerCell : Cell {
    
    let iconNode: ASImageNode
    let headlineNode: ASTextNode
    let subHeadlineNode: ASTextNode
    
    let streamerBlock: StreamerBlock
    let customStreamerStyles: CustomStreamerCellStyles

//    let headlineStyler: HeadlineStyler
//    let subHeadlineStyler: SubHeadlineStyler

    init(streamerBlock: StreamerBlock, styles: CustomStreamerCellStyles) {
        self.streamerBlock = streamerBlock
        iconNode = ASImageNode()
        headlineNode = ASTextNode()
        subHeadlineNode = ASTextNode()
        customStreamerStyles = styles
//        headlineStyler = HeadlineStyler(value: streamerBlock.text, block: streamerBlock)
//        subHeadlineStyler = SubHeadlineStyler(value: streamerBlock.author, block: streamerBlock)
        super.init(block: streamerBlock, styles: styles)
        addSubnode(iconNode)
        addSubnode(headlineNode)
        addSubnode(subHeadlineNode)
        
        if let _ = streamerBlock.author {
            iconNode.image = UIImage(named: "icon-quote")
        } else {
            iconNode.image = UIImage(named: "icon-streamer")
        }
        
        backgroundColor = customStreamerStyles.backgroundColor //streamerBlock.backgroundColor
        headlineNode.attributedString = customStreamerStyles.attributedHeadline
        subHeadlineNode.attributedString = customStreamerStyles.attributedSubHeadline
    }
    
    var subHeadlineMarginTop: CGFloat {
        guard customStreamerStyles.shouldRenderSubHeadline else { return 0 }
        return customStreamerStyles.subHeadlineMarginTop
    }

    var marginBottom: CGFloat {
        if customStreamerStyles.shouldRenderSubHeadline {
            return customStreamerStyles.subHeadlineMarginBottom
        }
        return customStreamerStyles.headlineMarginBottom
    }
    
    func headlineSize(constraintWidth: CGFloat) -> CGSize {
        return customStreamerStyles.attributedHeadline.boundingSizeForWidth(constraintWidth)
    }
    
    func subHeadlineSize(constraintWidth: CGFloat) -> CGSize {
        guard let subHeadline = customStreamerStyles.attributedSubHeadline else { return CGSizeZero }
        return subHeadline.boundingSizeForWidth(constraintWidth)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let contentPadding = customStreamerStyles.contentPadding
        let contentWidth = constrainedSize.width - (contentPadding.left + contentPadding.right)
        var contentHeight = contentPadding.top + contentPadding.bottom
        
        let headlineHeight = self.headlineSize(contentWidth).height
        let subHeadlineHeight = self.subHeadlineSize(contentWidth).height

        contentHeight += customStreamerStyles.iconMarginTop
        contentHeight += customStreamerStyles.iconSize
        contentHeight += customStreamerStyles.headlineMarginTop
        contentHeight += headlineHeight
        contentHeight += subHeadlineMarginTop
        contentHeight += subHeadlineHeight
        contentHeight += marginBottom
        
        return CGSize(width: constrainedSize.width, height: contentHeight)
    }
    
    override func layout() {
        super.layout()
        
        let contentRect = self.frame.insetsBy(customStreamerStyles.contentPadding)
        
        iconNode.frame = CGRect(x: customStreamerStyles.decorationPadding.left+customStreamerStyles.iconMarginLeft, y: customStreamerStyles.iconMarginTop, width: customStreamerStyles.iconSize, height: customStreamerStyles.iconSize)
        let headlineSize = self.headlineSize(contentRect.width)
        headlineNode.frame = CGRect(origin: CGPoint(x: contentRect.origin.x, y: CGRectGetMaxY(iconNode.frame)+customStreamerStyles.headlineMarginTop), size: headlineSize)
        let subHeadlineSize = self.subHeadlineSize(contentRect.width)
        subHeadlineNode.frame = CGRect(origin: CGPoint(x: contentRect.origin.x, y: CGRectGetMaxY(headlineNode.frame) + subHeadlineMarginTop), size: subHeadlineSize)
    }
}