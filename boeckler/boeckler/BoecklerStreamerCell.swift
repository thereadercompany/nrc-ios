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

class BoecklerStreamerCell : Cell {
    
    let iconNode: ASImageNode
    let headlineNode: ASTextNode
    let subHeadlineNode: ASTextNode
    
    let streamerBlock: StreamerBlock
    
    init(streamerBlock: StreamerBlock) {
        self.streamerBlock = streamerBlock
        iconNode = ASImageNode()
        headlineNode = ASTextNode()
        subHeadlineNode = ASTextNode()
        super.init(block: streamerBlock)
        addSubnode(iconNode)
        addSubnode(headlineNode)
        addSubnode(subHeadlineNode)
        
        if let _ = streamerBlock.subHeadline {
            iconNode.image = UIImage(named: "icon-quote")
        } else {
            iconNode.image = UIImage(named: "icon-streamer")
        }
        
        backgroundColor = streamerBlock.backgroundColor
        headlineNode.attributedString = streamerBlock.attributedHeadline
        subHeadlineNode.attributedString = streamerBlock.attributedSubHeadline
    }
    
    var subHeadlineMarginTop: CGFloat {
        guard streamerBlock.shouldRenderSubHeadline else { return 0 }
        return StreamerCellStyles.subHeadlineMarginTop
    }

    var marginBottom: CGFloat {
        if streamerBlock.shouldRenderSubHeadline {
            return StreamerCellStyles.subHeadlineMarginBottom
        }
        return StreamerCellStyles.headlineMarginBottom
    }
    
    func headlineSize(constraintWidth: CGFloat) -> CGSize {
        return streamerBlock.attributedHeadline.boundingSizeForWidth(constraintWidth)
    }
    
    func subHeadlineSize(constraintWidth: CGFloat) -> CGSize {
        guard let subHeadline = streamerBlock.attributedSubHeadline else { return CGSizeZero }
        return subHeadline.boundingSizeForWidth(constraintWidth)
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let contentPadding = block.contentPadding
        let contentWidth = constrainedSize.width - (contentPadding.left + contentPadding.right)
        var contentHeight = contentPadding.top + contentPadding.bottom
        
        let headlineHeight = self.headlineSize(contentWidth).height
        let subHeadlineHeight = self.subHeadlineSize(contentWidth).height

        contentHeight += StreamerCellStyles.iconMarginTop
        contentHeight += StreamerCellStyles.iconSize
        contentHeight += StreamerCellStyles.headlineMarginTop
        contentHeight += headlineHeight
        contentHeight += subHeadlineMarginTop
        contentHeight += subHeadlineHeight
        contentHeight += marginBottom
        
        return CGSize(width: constrainedSize.width, height: contentHeight)
    }
    
    override func layout() {
        super.layout()
        
        let contentRect = self.frame.insetsBy(block.contentPadding)
        
        iconNode.frame = CGRect(x: StreamerCellStyles.iconMarginLeft, y: StreamerCellStyles.iconMarginTop, width: StreamerCellStyles.iconSize, height: StreamerCellStyles.iconSize)
        let headlineSize = self.headlineSize(contentRect.width)
        headlineNode.frame = CGRect(origin: CGPoint(x: contentRect.origin.x, y: CGRectGetMaxY(iconNode.frame)+StreamerCellStyles.headlineMarginTop), size: headlineSize)
        let subHeadlineSize = self.subHeadlineSize(contentRect.width)
        subHeadlineNode.frame = CGRect(origin: CGPoint(x: contentRect.origin.x, y: CGRectGetMaxY(headlineNode.frame) + subHeadlineMarginTop), size: subHeadlineSize)
    }
}