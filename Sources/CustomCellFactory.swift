//
//  CustomCellFactory.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 08/05/15.
//

import Foundation
import AsyncDisplayKit
import Core


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
        switch block {
        case let sectionRef as SectionRefBlock:
            let node = contentNode(block: sectionRef)
            let decoration = Decoration(type: sectionRef.decoration, layerModel: .timeline)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        case let articleRef as ArticleRefBlock:
            let node = contentNode(block: articleRef)
            let decoration = Decoration(type: articleRef.decoration, layerModel: .timeline)
            return NRCCell(contentNode: node, decoration: decoration, delegate: delegate)
        case let articleHeader as ArticleHeaderBlock:
            return ArticleHeaderCell(articleHeaderBlock: articleHeader, styles: ArticleHeaderCellStyles())
        case let bylineBlock as BylineBlock:
            let node = contentNode(block: bylineBlock)
            return NRCCell(contentNode: node, decoration: nil, delegate: delegate)
        case let textBlock as TextBlock:
            return TextCell(richTextBlock: textBlock, styles: TextCellStyles())
        default:()
        }

        //TODO: fallback
        let fallbackBlock = FallbackBlock(block: block)
        return FallbackContentCell(fallbackContentBlock: fallbackBlock, styles: FallbackContentCellStyles())
    }
    
    //MARK: - SectionRef
    private func contentNode(block block: SectionRefBlock) -> SectionHeaderNode {
        let attributes = StringAttributes(font: Fonts.boldFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor())
        let title = NSAttributedString(string: block.title, attributes: attributes)
        let content = SectionHeaderContent(title: title)
        return SectionHeaderNode(content: content)
    }
    
    //MARK: - ArticleRef
    private func contentNode(block block: ArticleRefBlock) -> ArticleRefNode {
        let nodeType: ArticleRefNode.Type
        let titleFontSize: CGFloat
        let imageSize: ImageSize
        let padding: UIEdgeInsets
        var abstract: NSAttributedString? = nil
        
        // setup content by style and theme
        switch (block.blockStyle, block.theme) {
        case (.Large, .Urgent),(.Large, .Live):
            nodeType = ExtraLargeArticleRefNode.self
            titleFontSize = 26
            imageSize = .Large
            padding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: TimelineStyles.contentInset, right: TimelineStyles.contentInset)
            
            // abstract
            if let string = block.abstract {
                let abstractAttributes = StringAttributes(
                    font: Fonts.lightFont.fallbackWithSize(20),
                    foregroundColor: block.theme.fontColor,
                    lineSpacing: 3,
                    hyphenationFactor: 0.8
                )
                abstract = NSAttributedString(string: string, attributes: abstractAttributes)
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
            foregroundColor: block.theme.fontColor,
            lineSpacing: 2,
            hyphenationFactor: 0.8
        )
        let title = NSAttributedString(string: block.headline, attributes: titleAttributes)
        let imageURL = imagePolicy.URL(media: block.media, size: imageSize)
        
        let content = ArticleRefNodeContent(
            articleIdentifier: block.articleIdentifier,
            url: block.url,
            title: title,
            abstract: abstract,
            label: block.labelContent,
            line: block.lineModel,
            imageURL: imageURL,
            backgroundColor: block.theme.backgroundColor,
            padding: padding
        )
        
        return nodeType.init(content: content)
    }
    
    //MARK: - Byline
    private func contentNode(block block: BylineBlock) -> BylineNode {
        let attributes = StringAttributes(
            font: Fonts.alternativeMediumFont.fallbackWithSize(15),
            foregroundColor: Colors.defaultFontColor,
            lineSpacing: 3
        )
        let text = NSAttributedString(string: block.plainText, attributes: attributes)
        let content = BylineContent(icon: block.icon, text: text)
        return BylineNode(content: content)
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
        //TODO: is dit nog nodig? topInset: 15, bottomInset: 4) anders op te lossen bv in contentpadding?
        return DecorationLayerModel(
            color: Colors.articleBackgroundColor,
            border: Border(color: Colors.insetLineColor),
            cornerInfo: CornerInfo(radius: 3),
            padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
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
}
