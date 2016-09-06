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
 Implements a Renderer based on the AsyncDisplayKit by Facebook
 */


class NRCCellFactory: CellFactory {
    let trackerFactory: TrackerFactory
    let imagePolicy: ImagePolicy
    let dataController: BlockContextDataController

    init(trackerFactory: TrackerFactory, dataController: BlockContextDataController, imagePolicy: ImagePolicy) {
        self.trackerFactory = trackerFactory
        self.dataController = dataController
        self.imagePolicy = imagePolicy
    }

    func cell(block block: Block, delegate: CellDelegate?) -> ASCellNode {
        switch block {
        case let sectionRef as SectionRefBlock:
            let node: SectionHeaderNode = contentNode(block: sectionRef)
            return NRCCell(contentNode: node, delegate: delegate)
        case let articleRef as ArticleRefBlock:
            return ArticleRefCell(articleRef: articleRef, dataController: dataController, cellFactory: self, styles: ArticleRefCellStyles())
//            let node: ArticleRefNode = contentNode(block: articleRef)
//            return NRCCell(contentNode: node, delegate: delegate)
        default:()
        }

        //TODO: fallback
        let fallbackBlock = FallbackBlock(block: block)
        return FallbackContentCell(fallbackContentBlock: fallbackBlock, styles: FallbackContentCellStyles())
    }
    
    private func contentNode(block block: SectionRefBlock) -> SectionHeaderNode {
        let attributes = StringAttributes(font: Fonts.boldFont.fallbackWithSize(20), foregroundColor: UIColor.blackColor())
        let title = NSAttributedString(string: block.title, attributes: attributes)

        let model = SectionHeaderContent(title: title)
        model.decoration = block.decoration
        model.decorationModel = timelineDecorationModel
        return SectionHeaderNode(model: model)
    }

    private func contentNode(block block: ArticleRefBlock) -> ArticleRefNode {
        let titleFontSize: CGFloat
        let nodeType: ArticleRefNode.Type
        let contentPadding: UIEdgeInsets
        let imageSize: ImageSize
        
        switch (block.style, block.theme) {
        case (BlockStyle.Large, .Urgent), (BlockStyle.Large, .Live):
            nodeType = ExtraLargeArticleRefNode.self
            titleFontSize = 26
            imageSize = .Large
            contentPadding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (BlockStyle.Large, _):
            nodeType = LargeArticleRefNode.self
            titleFontSize = 22
            imageSize = .Medium
            contentPadding = UIEdgeInsets(top: 20, left: TimelineStyles.contentInset, bottom: 20, right: TimelineStyles.contentInset)
        default:
            nodeType = NormalArticleRefNode.self
            titleFontSize = 19
            imageSize = .Small
            contentPadding = UIEdgeInsets(top: 20, left: TimelineStyles.contentInset, bottom: 20, right: TimelineStyles.contentInset)
        }
        
        let titleAttributes = StringAttributes(
            font: Fonts.mediumFont.fallbackWithSize(titleFontSize),
            foregroundColor: Colors.defaultFontColor,
            lineSpacing: 2,
            hyphenationFactor: 0.8
        )
        
        let title = NSAttributedString(string: block.headline, attributes: titleAttributes)
        let model = ArticleRefNodeContent(articleIdentifier: block.articleIdentifier, url: block.url, title: title, line: block.line)
        model.image = imagePolicy.URL(media: block.media, size: imageSize)
        model.backgroundColor = block.backgroundColor
        model.decoration = block.decoration
        model.decorationModel = timelineDecorationModel
        model.contentPadding = contentPadding
        
        return nodeType.init(model: model)
    }
}

private let timelineDecorationModel = DecorationModel(
    color: Colors.timelineBackgroundColor,
    cornerInfo: CornerInfo(radius: 8),
    padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
)

extension ArticleRefBlock {
    var line: LineModel? {
        let thickness: CGFloat = 0.5
        let color: UIColor
        
        switch (decoration, theme) {
        case (.Bottom, _), (.None, _):
            return nil
        case (_, .Urgent):
            color = UIColor(hex: 0x555555)
        case (_, .Live), (_, .Highlight):
            color = UIColor(hex: 0xD9BBBB)
        default:
            color = Colors.defaultLineColor
        }
        
        return LineModel(color: color, thickness: thickness)
    }
}
