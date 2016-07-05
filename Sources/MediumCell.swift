//
//  MediumCell.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 19/11/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MediumCell: MediaCell, ArticleRefContaining, ImagePreloading, LabelNodeContaining , DateLabelNodeContaining {
    let labelNode = LabelNode()
    let dateLabelNode = LabelNode()
    let titleNode = ASTextNode()
    let richTextNode = ASTextNode()
    let sectionNode = ASTextNode()
    let lineNode = ASDisplayNode()
    
    // frame cache
    private var labelFrame = CGRectZero
    private var dateLabelFrame = CGRectZero
    private var titleFrame = CGRectZero
    private var richTextFrame = CGRectZero
    private var sectionFrame = CGRectZero
    
    let articleRef: ArticleRefBlock
    var preloadedImage: UIImage?
    
    init(articleRef: ArticleRefBlock) {
        self.articleRef = articleRef
        super.init(block: articleRef)
        
        addSubnode(labelNode)
        addSubnode(dateLabelNode)
        addSubnode(titleNode)
        addSubnode(richTextNode)
        addSubnode(sectionNode)
        addSubnode(lineNode)
        addSubnode(dateLabelNode)
        
        initializeLabelNode()
        initializeDateLabelNode()
        
        // headline
        titleNode.attributedString = articleRef.attributedTitle
        
        // rich text
        richTextNode.attributedString = articleRef.attributedRichText
        
        // section
        sectionNode.attributedString = articleRef.attributedSection
        
        // line
        lineNode.backgroundColor = articleRef.lineColor
    }
    
    override func didLoad() {
        super.didLoad()
        didLoadLabelNode()
        didLoadDateLabelNode()
    }
    
    var mediaScales: [CGFloat] {
        return [1]
    }
    
    //MARK: - Rects
    func contentRect(constrainedRect: CGRect) -> CGRect {
        return constrainedRect.insetsBy(articleRef.totalPadding)
    }
    
    func richTextRect(contentRect contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        let insets = articleRef.shouldRenderRichText ? MediumCellStyles.richTextInsets : CGPointZero
        let origin = CGPoint(x: contentRect.minX, y: titleRect.maxY + insets.y)
        
        if let exclusionPath = richTextExclusionPath(origin: origin, imageRect: imageRect, titleRect: titleRect) {
            richTextNode.exclusionPaths = [exclusionPath]
        }
        
        var size = articleRef.shouldRenderRichText ? richTextNode.measure(contentRect.size) : CGSizeZero
        size.width = contentRect.width
        return CGRect(origin: origin, size: size)
    }
    
    override func imageRect(constrainedRect: CGRect) -> CGRect {
        let contentRect = self.contentRect(constrainedRect)
        let labelRect = self.labelRect(contentRect: constrainedRect)
        let dateLabelRect = self.dateLabelRect(contentRect: constrainedRect)
        let highestLabel = rectWithHighestMaxY(labelRect, dateLabelRect)
        let labelBottom = highestLabel.maxY
        
        let titleInset = articleRef.shouldRenderLabel || articleRef.shouldRenderDate ?  MediumCellStyles.titleInsets.y : 0
        let originY = contentRect.minY + labelBottom + titleInset
        let size = mediaNode.shouldRenderImage ? MediumCellStyles.imageSize : CGSizeZero
        let originX = contentRect.maxX - size.width
        let origin = CGPoint(x: originX, y: originY)
        return CGRect(origin: origin, size: size)
    }
    
    func richTextExclusionPath(origin origin: CGPoint, imageRect: CGRect, titleRect: CGRect) -> UIBezierPath? {
        guard articleRef.shouldRenderRichText && mediaNode.shouldRenderImage else {
            return nil
        }
        
        let spacing = MediumCellStyles.imageSpacing
        let width = imageRect.width + spacing.x
        let height = max(0,imageRect.maxY - origin.y + spacing.y)
        let exclusionOriginX = (imageRect.minX - spacing.x) - origin.x
        let exclusionOriginY = max(origin.y, imageRect.minY) - origin.y
        let exclusionRect = CGRect(x: exclusionOriginX, y: exclusionOriginY, width: width, height: height)
        return UIBezierPath(rect: exclusionRect)
    }
    
    func titleRect(contentRect contentRect: CGRect, imageRect: CGRect, labelRect: CGRect) -> CGRect {
        let insets = articleRef.shouldRenderLabel || articleRef.shouldRenderDate ? MediumCellStyles.titleInsets : CGPointZero
        let originX = contentRect.minX
        let originY = labelRect.maxY + insets.y
        let origin = CGPoint(x: originX, y: originY)
        let exclusionPath = titleExclusionPath(origin: origin, imageRect: imageRect, labelRect: labelRect)
        titleNode.exclusionPaths = [exclusionPath]
        let width = contentRect.width
        let size = titleNode.measure(CGSize(width: width, height: CGFloat.max))
        
        return CGRect(origin: origin, size: size)
    }
    
    func titleExclusionPath(origin origin: CGPoint, imageRect: CGRect, labelRect: CGRect) -> UIBezierPath {
        let spacing = MediumCellStyles.imageSpacing
        let width = imageRect.width + spacing.x
        let height = imageRect.maxY - origin.y + spacing.y
        let exclusionOriginX = (imageRect.minX - spacing.x) - origin.x
        let exclusionOriginY = max(origin.y, imageRect.minY) - origin.y
        let exclusionRect = CGRect(x: exclusionOriginX, y: exclusionOriginY, width: width, height: height)
        return UIBezierPath(rect: exclusionRect)
    }
    
    func sectionRect(contentRect contentRect: CGRect, rectAbove: CGRect) -> CGRect {
        let size = sectionNode.measure(contentRect.size)
        let x = contentRect.maxX - size.width
        let y = rectAbove.maxY + MediumCellStyles.sectionMarginTop
        let origin = CGPoint(x: x, y: y)
        return CGRect(origin: origin, size: size)
    }
    
    //MARK: - Layouting
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let constrainedRect = CGRect(origin: CGPointZero, size: constrainedSize)
        let contentRect = self.contentRect(constrainedRect)
        let imageRect = self.imageRect(constrainedRect)
        mediaNode.mediaSize = MediaSize(size: imageRect.size)
        let labelRect = self.labelRect(contentRect: contentRect)
        self.labelFrame = labelRect
        
        let dateLabelRect = self.dateLabelRect(contentRect: contentRect)
        self.dateLabelFrame = dateLabelRect
        let highestLabelRect = rectWithHighestMaxY(labelRect, dateLabelRect)
        
        let titleRect = self.titleRect(contentRect: contentRect, imageRect: imageRect, labelRect: highestLabelRect)
        self.titleFrame = titleRect
        
        let richTextRect = self.richTextRect(contentRect: contentRect, imageRect: imageRect, titleRect: titleRect)
        self.richTextFrame = richTextRect
        
        let lowestExtendingRect = rectWithHighestMaxY(imageRect, richTextRect)
        var height = lowestExtendingRect.maxY
        
        if articleRef.shouldRenderSection {
            let sectionRect = self.sectionRect(contentRect: contentRect, rectAbove: lowestExtendingRect)
            sectionFrame = sectionRect
            height = sectionRect.maxY
        }
        
        height += TimelineStyles.lineThickness + articleRef.totalPadding.bottom
        
        return CGSize(width: constrainedSize.width, height: height)
    }
    
    override func layout() {
        super.layout()
        // label
        let labelRect = self.labelFrame
        labelNode.frame = labelRect
        labelNode.hidden = !articleRef.shouldRenderLabel
        
        // date label
        let dateLabelRect = self.dateLabelFrame
        dateLabelNode.frame = dateLabelRect
        dateLabelNode.hidden = !articleRef.shouldRenderDate
        
        // title
        let titleRect = self.titleFrame
        titleNode.frame = titleRect
        
        // richtext
        richTextNode.frame = self.richTextFrame
        
        // section
        sectionNode.frame = self.sectionFrame
        sectionNode.hidden = !articleRef.shouldRenderSection
        
        // line
        let lineContentRect = frame.insetsBy(block.decorationPadding)
        layoutLine(lineContentRect)
    }
    
    func layoutLine(contentRect: CGRect) {
        switch block.decoration {
        case .Top, .Middle:
            lineNode.frame = CGRect(x: contentRect.origin.x+TimelineStyles.lineInset, y: contentRect.height-TimelineStyles.lineThickness, width: contentRect.width-(2*TimelineStyles.lineInset), height: TimelineStyles.lineThickness)
        default:
            self.lineNode.frame = CGRectZero
        }
    }
    
    override func handleTap() {
        openArticle()
    }
    
    override func fetchData() {
        super.fetchData()
        preloadArticleHeaderImage()
    }
    
    override func visibilityDidChange(visible: Bool) {
        super.visibilityDidChange(visible)
        pulsateLabelBullet(visible)
    }
}