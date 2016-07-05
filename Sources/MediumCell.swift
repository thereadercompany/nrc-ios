//
//  MediumCell.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 19/11/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MediumCell: MediaCell {
    let labelNode = LabelNode()
    let dateLabelNode = LabelNode()
    let titleNode = ASTextNode()
    let richTextNode = ASTextNode()
    let sectionNode = ASTextNode()
    let lineNode = ASDisplayNode()
    
    // TODO: the styler objects should be injected
    let labelStyler: LabelStyler
    let dateLabelStyler: DateLabelStyler
    let titleStyler: PlainTextStyler
    let richTextStyler : RichTextStyler
    let sectionStyler: SectionStyler
    let lineStyler: LineStyler
    
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
        labelStyler = LabelStyler(value: articleRef.label, block: articleRef)
        dateLabelStyler = DateLabelStyler(date: articleRef.date, block: articleRef)
        titleStyler = PlainTextStyler(value: articleRef.headline, block: articleRef)
        richTextStyler = RichTextStyler(value: articleRef.abstract, block: articleRef)
        sectionStyler = SectionStyler(value: articleRef.section, block: articleRef)
        lineStyler = LineStyler(value: nil, block: articleRef)
        
        super.init(block: articleRef)
        
        addSubnode(labelNode)
        addSubnode(dateLabelNode)
        addSubnode(titleNode)
        addSubnode(richTextNode)
        addSubnode(sectionNode)
        addSubnode(lineNode)
        addSubnode(dateLabelNode)
        
        if labelStyler.shouldRenderLabel {
            labelNode.text = labelStyler.attributedLabel
            labelNode.applyStyle(labelStyler.labelTextInsets, backgroundColor:labelStyler.labelBackgroundColor, cornerRadius: labelStyler.labelCornerRadius)
        }
        
        if dateLabelStyler.shouldRenderDate {
            dateLabelNode.text = dateLabelStyler.attributedDate
            dateLabelNode.applyStyle(dateLabelStyler.dateInset, backgroundColor:dateLabelStyler.dateBackgroundColor, cornerRadius: dateLabelStyler.dateCornerRadius)
        }
        
        // headline
        titleNode.attributedString = titleStyler.attributedPlainText
        
        // rich text
        richTextNode.attributedString = richTextStyler.attributedRichText
        
        // section
        sectionNode.attributedString = sectionStyler.attributedSection
        
        // line
        lineNode.backgroundColor = lineStyler.lineColor
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    var mediaScales: [CGFloat] {
        return [1]
    }
    
    //MARK: - Rects
    func contentRect(constrainedRect: CGRect) -> CGRect {
        return constrainedRect.insetsBy(articleRef.contentPadding)
    }
    
    func richTextRect(contentRect contentRect: CGRect, imageRect: CGRect, titleRect: CGRect) -> CGRect {
        let insets = richTextStyler.shouldRenderRichText ? MediumCellStyles.richTextInsets : CGPointZero
        let origin = CGPoint(x: contentRect.minX, y: titleRect.maxY + insets.y)
        
        if let exclusionPath = richTextExclusionPath(origin: origin, imageRect: imageRect, titleRect: titleRect) {
            richTextNode.exclusionPaths = [exclusionPath]
        }
        
        var size = richTextStyler.shouldRenderRichText ? richTextNode.measure(contentRect.size) : CGSizeZero
        size.width = contentRect.width
        return CGRect(origin: origin, size: size)
    }
    
    override func imageRect(constrainedRect: CGRect) -> CGRect {
        let contentRect = self.contentRect(constrainedRect)
        let labelRect = self.labelRect(contentRect: constrainedRect)
        let dateLabelRect = self.dateLabelRect(contentRect: constrainedRect)
        let highestLabel = rectWithHighestMaxY(labelRect, dateLabelRect)
        let labelBottom = highestLabel.maxY
        
        let titleInset = labelStyler.shouldRenderLabel || dateLabelStyler.shouldRenderDate ?  MediumCellStyles.titleInsets.y : 0
        let originY = contentRect.minY + labelBottom + titleInset
        let size = articleRef.shouldRenderImage ? MediumCellStyles.imageSize : CGSizeZero
        let originX = contentRect.maxX - size.width
        let origin = CGPoint(x: originX, y: originY)
        return CGRect(origin: origin, size: size)
    }
    
    func richTextExclusionPath(origin origin: CGPoint, imageRect: CGRect, titleRect: CGRect) -> UIBezierPath? {
        guard richTextStyler.shouldRenderRichText && articleRef.shouldRenderImage else {
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
        let insets = labelStyler.shouldRenderLabel || dateLabelStyler.shouldRenderDate ? MediumCellStyles.titleInsets : CGPointZero
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
    
    func labelRect(contentRect contentRect: CGRect) -> CGRect {
        guard labelStyler.shouldRenderLabel else {
            return CGRect(origin: contentRect.origin, size: CGSizeZero)
        }
        let inset = LabelStyles.labelInset
        let origin = CGPoint(x: contentRect.origin.x + inset.x, y: contentRect.origin.y + inset.y)
        let size = labelNode.measure(CGSize.max)
        return CGRect(origin: origin, size: size)
    }
    
    func sectionRect(contentRect contentRect: CGRect, rectAbove: CGRect) -> CGRect {
        let size = sectionNode.measure(contentRect.size)
        let x = contentRect.maxX - size.width
        let y = rectAbove.maxY + MediumCellStyles.sectionMarginTop
        let origin = CGPoint(x: x, y: y)
        return CGRect(origin: origin, size: size)
    }
    
    func dateLabelRect(contentRect contentRect: CGRect) -> CGRect {
        let size = dateLabelStyler.shouldRenderDate ? dateLabelNode.measure(CGSize(width: contentRect.width, height: contentRect.height)) : CGSizeZero
        let x = contentRect.maxX - size.width
        let y = contentRect.minY + dateLabelStyler.dateInset.top
        let origin = CGPoint(x: x, y: y)
        return CGRect(origin: origin, size: size)
    }
    
    //MARK: - Layouting
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let constrainedRect = CGRect(origin: CGPointZero, size: constrainedSize)
        let contentRect = self.contentRect(constrainedRect)
        let imageRect = self.imageRect(constrainedRect)
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
        
        if sectionStyler.shouldRenderSection {
            let sectionRect = self.sectionRect(contentRect: contentRect, rectAbove: lowestExtendingRect)
            sectionFrame = sectionRect
            height = sectionRect.maxY
        }
        
        height += TimelineStyles.lineHeight + articleRef.contentPadding.bottom
        
        return CGSize(width: constrainedSize.width, height: height)
    }
    
    override func layout() {
        super.layout()
        // label
        let labelRect = self.labelFrame
        labelNode.frame = labelRect
        labelNode.hidden = !labelStyler.shouldRenderLabel
        
        // date label
        let dateLabelRect = self.dateLabelFrame
        dateLabelNode.frame = dateLabelRect
        dateLabelNode.hidden = !dateLabelStyler.shouldRenderDate
        
        // title
        let titleRect = self.titleFrame
        titleNode.frame = titleRect
        
        // richtext
        richTextNode.frame = self.richTextFrame
        
        // section
        sectionNode.frame = self.sectionFrame
        sectionNode.hidden = !sectionStyler.shouldRenderSection
        
        // line
        let lineContentRect = frame.insetsBy(block.decorationPadding)
        layoutLine(lineContentRect)
    }
    
    func layoutLine(contentRect: CGRect) {
        switch block.decoration {
        case .Top, .Middle:
            lineNode.frame = CGRect(x: contentRect.origin.x+TimelineStyles.lineInset, y: contentRect.height-TimelineStyles.lineHeight, width: contentRect.width-(2*TimelineStyles.lineInset), height: TimelineStyles.lineHeight)
        default:
            self.lineNode.frame = CGRectZero
        }
    }
    
    override func handleTap() {
        super.handleTap()
        delegate?.handleCellAction(self, cellAction:.ShowArticle(articleRef, imageNode.image))
    }
    
    override func fetchData() {
        super.fetchData()
        if !articleRef.shouldRenderImage {
            preloadImage()
        }
    }
    
    override func visibilityDidChange(visible: Bool) {
        super.visibilityDidChange(visible)
        pulsateLabelBullet(visible)
    }
    
    func pulsateLabelBullet(pulsate: Bool) {
        //TODO
//        if articleRef.shouldRenderLabelBullet {
//            labelNode.pulsateBullet(pulsate)
//        }
    }
}