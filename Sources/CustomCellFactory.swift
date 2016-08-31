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
class CustomCellFactory: CellFactory {
    
    let trackerFactory: TrackerFactory
    let dataController: BlockContextDataController
    let styleFactory: CellStyleFactory
    
    init(trackerFactory: TrackerFactory, dataController: BlockContextDataController, styleFactory: CellStyleFactory) {
        self.trackerFactory = trackerFactory
        self.dataController = dataController
        self.styleFactory = styleFactory
    }
    
    func cell(forBlock block: Block) -> Cell {
        if let cell = createCell(block) {
            if let trackingData = block.trackingData {
                cell.tracker = trackerFactory.createTracker(trackingData)
            }
            return cell
        }
        let fallbackBlock = FallbackBlock(block: block)
        return FallbackContentCell(fallbackContentBlock: fallbackBlock, styles: FallbackContentCellStyles())
    }
    
    func createCell(block: Block) -> Cell? {
        switch block {
        case let block as ArticleRefBlock: return createCell(block)
        case let block as SectionRefBlock: return createCell(block)
        case let block as ArticleHeaderBlock: return createCell(block)
        case let block as BylineBlock: return createCell(block)
        case let block as DividerBlock: return createCell(block)
        case let block as FallbackBlock: return createCell(block)
        case let block as VimeoBlock: return createCell(block)
        case let block as YoutubeBlock: return createCell(block)
        case let block as ImageBlock: return createCell(block)
        case let block as ServerErrorBlock: return createCell(block)
        case let block as SpacingBlock: return createCell(block)
        case let block as StreamerBlock: return createCell(block)
        case let block as TextBlock: return createCell(block)
        case let block as PlainTextBlock: return createCell(block)
        case let block as TweetBlock: return createCell(block)
        case let block as UnsupportedContentBlock: return createCell(block)
        default: return nil
        }
    }
    
    private func createCell(block: SectionRefBlock) -> Cell? {
        return SectionHeaderCell(sectionRef: block, styles: CellStyles())
    }
    
    private func createCell(block: ArticleRefBlock) -> Cell? {
        let styles = styleFactory.headline(block)
        
        switch (block.style, block.theme) {
        case (BlockStyle.Large, .Urgent),(BlockStyle.Large, .Live):
            return ExtraLargeArticleRefCell(articleRef: block, dataController: dataController, cellFactory: self, styles: styles)
        case (BlockStyle.Large, _):
            return LargeArticleRefCell(articleRef: block, dataController: dataController, cellFactory: self, styles: styles)
        default:
            return NormalArticleRefCell(articleRef: block, dataController: dataController, cellFactory: self, styles: styles)
        }
    }
    
    private func createCell(block: ArticleHeaderBlock) -> Cell? {
        return ArticleHeaderCell(articleHeaderBlock: block, styles: styleFactory.articleHeader(block))
    }
    
    private func createCell(block: DividerBlock) -> Cell? {
        return CustomDividerCell(block: block, styles: styleFactory.divider(block))
    }
    
    private func createCell(block: FallbackBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: styleFactory.fallback(block))
    }
    
    private func createCell(block: ImageBlock) -> Cell? {
        return ImageCell(block: block, styles: styleFactory.image(block))
    }
    
    private func createCell(block: PlainTextBlock) -> Cell? {
        switch block.style {
        case BlockStyle.H1, BlockStyle.H2, BlockStyle.InsetH1, BlockStyle.InsetH2, BlockStyle.InsetH3:
            return PlainTextCell(plainTextBlock: block, styles: styleFactory.plainText(block))
        default:
            return nil
        }
    }
    
    private func createCell(block: BylineBlock) -> Cell? {
        return BylineCell(bylineBlock: block, styles: CellStyles())
    }
    
    private func createCell(block: ServerErrorBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: FallbackContentCellStyles())
    }
    
    private func createCell(block: SpacingBlock) -> Cell? {
        switch (block.context,block.style) {
        case (CoreBlockContextType.Article, BlockStyle.ArticleFooter):
            return FooterCell(spacingBlock: block, styles: styleFactory.footer(block))
        case (CoreBlockContextType.Article, BlockStyle.Normal), (CoreBlockContextType.Article, BlockStyle.Inset), (CoreBlockContextType.Article, BlockStyle.Image):
            return SpacingCell(spacingBlock: block, styles: styleFactory.spacing(block))
        case (CustomBlockContextType.Timeline, _):
            return SpacingCell(spacingBlock: block, styles: styleFactory.spacing(block))
        default:
            return nil
        }
    }
    
    private func createCell(block: StreamerBlock) -> Cell? {
        return CustomStreamerCell(streamerBlock: block, styles: styleFactory.streamer(block))
    }
    
    private func createCell(block: TextBlock) -> Cell? {
        switch block.style {
        case BlockStyle.Normal, BlockStyle.Inset, BlockStyle.Intro, BlockStyle.Byline:
            return TextCell(richTextBlock: block, styles: styleFactory.text(block))
        default:
            return nil
        }
    }
    
    private func createCell(block: TweetBlock) -> Cell? {
        return TweetCell(tweetBlock: block, styles: styleFactory.tweet(block))
    }
    
    private func createCell(block: UnsupportedContentBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: FallbackContentCellStyles())
    }
    
    private func createCell(block: VimeoBlock) -> Cell? {
        return VimeoCell(vimeoBlock: block, styles: styleFactory.vimeo(block))
    }
    
    private func createCell(block: YoutubeBlock) -> Cell? {
        return YoutubeCell(youtubeBlock: block, styles: styleFactory.youtube(block))
    }
}