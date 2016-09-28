//
//  CustomCellFactory.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 08/05/15.
//

import Foundation
import AsyncDisplayKit
import Core
import DTCoreText

/**
 Provides a Cell with the correct contentNode for a Block
 */
class CellFactory: Core.CellFactory {
    private let trackerFactory: TrackerFactory
    private let imagePolicy: ImagePolicy
    private let dataController: BlockContextDataController

    init(trackerFactory: TrackerFactory, dataController: BlockContextDataController, imagePolicy: ImagePolicy) {
        self.trackerFactory = trackerFactory
        self.dataController = dataController
        self.imagePolicy = imagePolicy
    }

    func cell(block block: Block, delegate: CellDelegate?) -> ASCellNode {
        let decorationLayerModel = DecorationLayerModel.model(block: block)
        let decoration = Decoration(type: block.decoration, layerModel: decorationLayerModel)

        switch block {
        case let sectionRef as SectionRefBlock:
            let node = contentNode(block: sectionRef)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        
        case let articleRef as ArticleRefBlock:
            let node = contentNode(block: articleRef)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        
        case let articleHeader as ArticleHeaderBlock:
            return ArticleHeaderCell(articleHeaderBlock: articleHeader, styles: ArticleHeaderCellStyles())
        case let bylineBlock as BylineBlock:
            let node = contentNode(block: bylineBlock)
            return NRCCell(contentNode: node, decoration: nil, delegate: delegate)
        case let spacingBlock as SpacingBlock:
            let node = contentNode(block: spacingBlock)
            return NRCCell(contentNode: node, decoration: nil, delegate: delegate)
        case let textBlock as TextBlock:
            let node = contentNode(block: textBlock)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        case let plainTextBlock as PlainTextBlock:
            let node = contentNode(block: plainTextBlock)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        case let imageBlock as ImageBlock:
            let node = contentNode(block: imageBlock)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        case let dividerBlock as DividerBlock:
            let node = contentNode(block: dividerBlock)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        default:()
        }

        //TODO: fallback
        let fallbackBlock = FallbackBlock(block: block)
        return FallbackContentCell(fallbackContentBlock: fallbackBlock, styles: FallbackContentCellStyles())
    }
    
    //MARK: - SectionRef
    private func contentNode(block block: SectionRefBlock) -> SectionHeaderNode {
        let attributes = StringAttributes(font: Fonts.mediumFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor())
        let title = NSAttributedString(string: block.title, attributes: attributes)
        let content = SectionHeaderContent(title: title)
        return SectionHeaderNode(content: content)
    }
    
    //MARK: - ArticleRef
    private func contentNode(block articleRef: ArticleRefBlock) -> ArticleRefNode {
        let nodeType: ArticleRefNode.Type
        let titleFontSize: CGFloat
        let imageSize: ImageSize
        let padding: UIEdgeInsets
        var abstract: NSAttributedString? = nil
        
        // setup content by style and theme
        switch (articleRef.blockStyle, articleRef.theme) {
        case (.Large, .Urgent),(.Large, .Live):
            nodeType = ExtraLargeArticleRefNode.self
            titleFontSize = 26
            imageSize = .Large
            padding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
            
            // abstract
            if let string = articleRef.abstract {
                let abstractAttributes = StringAttributes(
                    font: Fonts.lightFont.fallbackWithSize(20),
                    foregroundColor: articleRef.theme.fontColor,
                    lineSpacing: 3,
                    hyphenationFactor: 0.8
                )
                abstract = NSAttributedString(string: string, attributes: abstractAttributes, style: articleRef.blockStyle)
            }
        case (.Large, .Highlight),(.Large, .Default):
            nodeType = LargeArticleRefNode.self
            titleFontSize = 22
            imageSize = .Medium
            padding = UIEdgeInsets(top: TimelineStyles.contentInset, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
        default:
            nodeType = NormalArticleRefNode.self
            titleFontSize = 19
            imageSize = .Small
            padding = UIEdgeInsets(top: TimelineStyles.contentInset, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
        }
        
        let titleAttributes = StringAttributes(
            font: Fonts.mediumFont.fallbackWithSize(titleFontSize),
            foregroundColor: articleRef.theme.fontColor,
            lineSpacing: 2,
            hyphenationFactor: 0.8
        )
        let title = NSAttributedString(string: articleRef.headline, attributes: titleAttributes, style: articleRef.blockStyle)
        let imageURL = imagePolicy.URL(media: articleRef.media, size: imageSize)
        
        let content = ArticleRefNodeContent(
            articleIdentifier: articleRef.articleIdentifier,
            url: articleRef.url,
            title: title,
            abstract: abstract,
            label: articleRef.labelContent,
            line: articleRef.lineModel,
            imageURL: imageURL,
            backgroundColor: articleRef.theme.backgroundColor,
            padding: padding
        )
        
        return nodeType.init(content: content)
    }
    
    //MARK: - Byline
    private func contentNode(block bylineBlock: BylineBlock) -> BylineNode {
        let attributes = StringAttributes(
            font: Fonts.alternativeMediumFont.fallbackWithSize(15),
            foregroundColor: Colors.defaultFontColor,
            lineSpacing: 3
        )
        let text = NSAttributedString(string: bylineBlock.plainText, attributes: attributes)
        let content = BylineContent(icon: bylineBlock.icon, text: text)
        return BylineNode(content: content)
    }
    
    //MARK: - Spacing
    private func contentNode(block spacingBlock: SpacingBlock) -> SpacingNode<SpacingContent> {
        let backgroundColor: UIColor
        switch spacingBlock.blockContext {
        case .Timeline:
            backgroundColor = Colors.timelineBackgroundColor
        case .Article:
            backgroundColor = Colors.articleBackgroundColor
        default:
            backgroundColor = Colors.defaultBackgroundColor
        }
        
        let content = SpacingContent(units: spacingBlock.size, multiplier: 1, backgroundColor: backgroundColor)
        return SpacingNode(content: content)
    }
    
    //MARK: - Text
    private func contentNode(block textBlock: TextBlock) -> TextNode<TextContent> {
        let font: UIFont
        let textColor: UIColor
        let lineSpacing: CGFloat
        let backgroundColor: UIColor
        let padding: UIEdgeInsets
        
        func insetPadding(decoration decoration: DecorationType) -> UIEdgeInsets {
            switch decoration {
            case .Top:
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            case .Middle:
                return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
            case .Bottom:
                return UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
            case .Full:
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            case .None:
                return UIEdgeInsets()
            }
        }
        
        switch textBlock.blockStyle {
        case .Normal:
            font = Fonts.textFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing =  8
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        case .BlockQuote:
            font = Fonts.mediumFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Information:
            font = Fonts.mediumFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleInformationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Recommendation:
            font = Fonts.lightFont.fallbackWithSize(17)
            textColor = Colors.defaultFontColor
            lineSpacing = 7
            backgroundColor = Colors.articleRecommendationBackgroundColor
            padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        case .Inset:
            font = Fonts.alternativeTextFont.fallbackWithSize(15)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: textBlock.decoration)
        case .InsetHeader:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.accentColor
            lineSpacing = 4
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: textBlock.decoration)
        case .InsetSubheader:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.insetBackgroundColor
            padding = insetPadding(decoration: textBlock.decoration)
        case .Intro:
            font = Fonts.lightFont.fallbackWithSize(22)
            textColor = Colors.defaultFontColor
            lineSpacing = 6
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        case .Subheader:
            font = Fonts.textFont.fallbackWithSize(20)
            textColor = Colors.defaultFontColor
            lineSpacing = 4
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        default:
            font = Fonts.textFont.fallbackWithSize(16)
            textColor = Colors.defaultFontColor
            lineSpacing = 0
            backgroundColor = Colors.cellBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 25, right: 20)
        }
        
        let attributes = StringAttributes(
            font: font,
            foregroundColor: textColor,
            lineSpacing: lineSpacing,
            hyphenationFactor: 0.8,
            styleSheet: .shared
        )
        let text = NSAttributedString(string: textBlock.richText, attributes: attributes, style: textBlock.blockStyle)
        let content = TextContent(text: text, backgroundColor: backgroundColor, padding: padding)
        return TextNode(content: content)
    }
    
    //MARK: - PlainText
    func contentNode(block textBlock: PlainTextBlock) -> TextNode<TextContent> {
        let font: UIFont
        let fontColor: UIColor
        let padding: UIEdgeInsets
        
        switch textBlock.blockStyle {
        case .Subheader:
            font = Fonts.mediumFont.fallbackWithSize(20)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: 20, bottom: 14, right: 20)
        case .InsetHeader:
            font = Fonts.alternativeMediumFont.fallbackWithSize(14)
            fontColor = Colors.accentColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 11, right: 15)
        case .InsetSubheader:
            font = Fonts.alternativeTextFont.fallbackWithSize(15)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 11, right: 15)
        default:
            font = Fonts.textFont.fallbackWithSize(14)
            fontColor = Colors.defaultFontColor
            padding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 25, right: ArticleStyles.textInset)
        }
        
        let attributes = StringAttributes(
            font: font,
            foregroundColor: fontColor,
            lineSpacing: 6,
            hyphenationFactor: 0.8,
            styleSheet: .shared
        )
        
        let text = NSAttributedString(string: textBlock.plainText, attributes: attributes)
        let content = TextContent(text: text, backgroundColor: Colors.cellBackgroundColor, padding: padding)
        return TextNode(content: content)
    }
    
    //MARK: - Image
    func contentNode(block imageBlock: ImageBlock) -> ImageNode<ImageContent> {
        let media = imageBlock.media
        let URL: CGSize -> NSURL = { [unowned self] size in
            return self.imagePolicy.URL(media: media, size: size)
        }
        
        let aspectRatio = media.aspectRatio ?? Media.defaultAspectRatio
        let image = Image(URL: URL, aspectRatio: aspectRatio)
        
        let backgroundColor: UIColor
        let padding: UIEdgeInsets
        let shouldRenderText: Bool
        switch imageBlock.blockStyle {
        case .Recommendation:
            backgroundColor = Colors.articleRecommendationBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        case .BlockQuote:
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        case .Information:
            backgroundColor = Colors.articleInformationBackgroundColor
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            shouldRenderText = false
        default:
            backgroundColor = Colors.imageBackgroundColor
            padding = UIEdgeInsets()
            shouldRenderText = true
        }

        // caption
        var caption: NSAttributedString? = nil
        if let string = imageBlock.caption where shouldRenderText {
            let attributes = StringAttributes(
                font: Fonts.alternativeTextFont.fallbackWithSize(16),
                foregroundColor: Colors.defaultFontColor,
                lineSpacing: 3,
                hyphenationFactor: 0.8,
                styleSheet: .shared
            )
            caption = NSAttributedString(string: string, attributes: attributes, style: imageBlock.blockStyle)
        }
        
        // credit
        var credit: NSAttributedString? = nil
        if let string = imageBlock.credit where shouldRenderText {
            let attributes = StringAttributes(
                font: Fonts.alternativeMediumFont.fallbackWithSize(15),
                foregroundColor: Colors.defaultFontColor,
                lineSpacing: 3,
                styleSheet: nil
            )
            credit = NSAttributedString(string: string, attributes: attributes, style: imageBlock.blockStyle)
        }
        
        let content = ImageContent(
            image: image,
            caption: caption,
            credit: credit,
            backgroundColor: backgroundColor,
            padding: padding
        )
        return ImageNode(content: content)
    }
    
    //MARK: - Divider
    func contentNode(block dividerBlock: DividerBlock) -> DividerNode<DividerContent> {
        let backgroundColor: UIColor
        let line: Line
        let padding: UIEdgeInsets
        
        switch (dividerBlock.blockContext, dividerBlock.blockStyle) {
        case (.Article, .Inset):
            backgroundColor = Colors.insetBackgroundColor
            line = Line(color: Colors.insetLineColor, thickness: 1)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .Recommendation):
            backgroundColor = Colors.articleRecommendationBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .BlockQuote):
            backgroundColor = Colors.articleBlockQuoteBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, .Information):
            backgroundColor = Colors.articleInformationBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case (.Article, _):
            backgroundColor = Colors.articleBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        case (.Timeline, _):
            backgroundColor = Colors.timelineBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        default:
            backgroundColor = Colors.dividerBackgroundColor
            line = Line(color: Colors.dividerLineColor, thickness: 0.5)
            padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        }
    
        var label: LabelContent? = nil
        if let string = dividerBlock.label {
            let attributes = StringAttributes(font: Fonts.labelFont.fallbackWithSize(10), foregroundColor: Colors.dividerTextColor, lineSpacing: 0)
            let text = NSAttributedString(string: string, attributes: attributes)
            label = LabelContent(text: text, insets: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        }
        
        let content = DividerContent(line: line,
                                     label: label,
                                     backgroundColor: backgroundColor,
                                     padding: padding
        )
        
        return DividerNode(content: content)
    }
}

//MARK: - Styling
private extension Theme {
    var backgroundColor: UIColor {
        switch self {
        case .Highlight:
            return Colors.nrcRedLight
        case .Live:
            return Colors.nrcRed
        case .Urgent:
            return Colors.nrcAnthracite
        default:
            return Colors.cellBackgroundColor
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .Live, .Urgent:
            return Colors.overlayFontColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var bullet: Bullet? {
        guard self == .Live else { return nil }
        return Bullet(color: .whiteColor(), radius: 4, pulsate: true)
    }
}

private extension ArticleRefBlock {
    var lineModel: Line? {
        let thickness: CGFloat = 0.5
        let color: UIColor
        
        // setup line by decoration and theme
        switch (decoration, theme) {
        case (.Bottom, _), (.None, _):
            // bottom and none decorations do not have a line
            return nil
        case (_, .Urgent):
            color = UIColor(hex: 0x555555)
        case (_, .Live), (_, .Highlight):
            color = UIColor(hex: 0xD9BBBB)
        default:
            color = Colors.defaultLineColor
        }
        
        return Line(color: color, thickness: thickness)
    }
    
    var labelContent: LabelContent? {
        guard let string = label else { return nil }

        let textColor: UIColor
        let insets: UIEdgeInsets
        let backgroundColor: UIColor?
        let border: Border?
        let corners: CornerInfo?
        
        switch (blockStyle, theme) {
        case (.Large, .Urgent),(.Large, .Live),(.Large, .Highlight):
            textColor = .whiteColor()
            insets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            backgroundColor = UIColor(hex: 0xD30910)
            border = nil
            corners = CornerInfo(radius: 10)
        case (.Large, .Default):
            textColor = Colors.labelTextColor
            insets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
            backgroundColor = Colors.labelBackgroundColor
            border = Border(color: Colors.labelBorderColor, width: 0.5)
            corners = CornerInfo(radius: 10)
        default:
            textColor = Colors.labelTextColor
            insets = UIEdgeInsets()
            backgroundColor = nil
            border = nil
            corners = nil
        }
        
        let attributes = StringAttributes(
            font: Fonts.labelFont.fallbackWithSize(10),
            foregroundColor: textColor,
            lineSpacing: 0
        )
        let text = NSAttributedString(string: string, attributes: attributes)

        return LabelContent(
            text: text,
            insets: insets,
            backgroundColor: backgroundColor,
            corners: corners,
            border: border,
            bullet: theme.bullet
        )
    }
}

// MARK - Decoration
extension DecorationLayerModel {
    static func model(block block: Block) -> DecorationLayerModel {
        switch (block.blockContext, block.blockStyle) {
        case (.Article, .Inset):
            return .inset
        case (.Article, _):
            return .article
        case (.Timeline, _):
            return .timeline
        default:
            return .null
        }
    }
    
    static var timeline: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.timelineBackgroundColor,
            cornerInfo: CornerInfo(radius: 8),
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        )
    }
    
    static var article: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.articleBackgroundColor,
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        )
    }
    
    static var inset: DecorationLayerModel {
        return DecorationLayerModel(
            color: Colors.articleBackgroundColor,
            border: Border(color: Colors.insetLineColor),
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top:0, left: 20, bottom: 20, right: 20)
        )
    }
    
    static var tweet: DecorationLayerModel {
        return  DecorationLayerModel(
            color: Colors.tweetBackgroundColor,
            border: Border(color: Colors.tweetBorderColor, width: 0.5),
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        )
    }
    
    // null value has no color, no padding, no border and no corner radius
    static var null: DecorationLayerModel {
        return DecorationLayerModel(
            color: UIColor.clearColor()
        )
    }
}
