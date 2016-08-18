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
    
    init(trackerFactory: TrackerFactory, dataController: BlockContextDataController) {
        self.trackerFactory = trackerFactory
        self.dataController = dataController
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
        case let block as ArticleHeaderBlock: return createCell(block)
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
        case let block as UnsupportedContentBlock: return createCell(block)
        default: return nil
        }
    }
    
    func createCell(block: ArticleRefBlock) -> Cell? {
        switch block.style {
        case  BlockStyle.Normal, BlockStyle.Highlight, BlockStyle.HighlightXL:
            return NormalHeadlineCell(articleRef: block, dataController: dataController, cellFactory: self, styles: CellStyleFactory.highlight(block))
        default:
            return nil
        }
    }
    
    func createCell(block: ArticleHeaderBlock) -> Cell? {
        return ArticleHeaderCell(articleHeaderBlock: block, styles: CellStyleFactory.articleHeader(block))
    }
    
    func createCell(block: DividerBlock) -> Cell? {
        return CustomDividerCell(block: block, styles: CellStyleFactory.divider(block))
    }
    
    func createCell(block: FallbackBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: CellStyleFactory.fallback(block))
    }
    
    func createCell(block: ImageBlock) -> Cell? {
        return ImageCell(block: block, styles: CellStyleFactory.image(block))
    }
    
    func createCell(block: PlainTextBlock) -> Cell? {
        switch block.style {
        case BlockStyle.H1, BlockStyle.H2, BlockStyle.InsetH1, BlockStyle.InsetH2:
            return PlainTextCell(plainTextBlock: block, styles: CellStyleFactory.plainText(block))
        default:
            return nil
        }
    }
    
    func createCell(block: ServerErrorBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: FallbackContentCellStyles())
    }

    func createCell(block: SpacingBlock) -> Cell? {
        switch (block.context,block.style) {
        case (CoreBlockContextType.Article, BlockStyle.ArticleFooter):
            return FooterCell(spacingBlock: block, styles: CellStyleFactory.footer(block))
        case (CoreBlockContextType.Article, BlockStyle.Normal), (CoreBlockContextType.Article, BlockStyle.Inset), (CoreBlockContextType.Article, BlockStyle.Image):
            return SpacingCell(spacingBlock: block, styles: CellStyleFactory.spacing(block))
        case (CustomBlockContextType.Timeline, _):
            return SpacingCell(spacingBlock: block, styles: CellStyleFactory.spacing(block))
        default:
            return nil
        }
    }
    
    func createCell(block: StreamerBlock) -> Cell? {
        return CustomStreamerCell(streamerBlock: block, styles: CellStyleFactory.streamer(block))
    }
    
    func createCell(block: TextBlock) -> Cell? {
        switch block.style {
        case BlockStyle.Normal, BlockStyle.Inset, BlockStyle.Intro, BlockStyle.Byline:
            return TextCell(richTextBlock: block, styles: CellStyleFactory.text(block))
        default:
            return nil
        }
    }
    
    func createCell(block: TweetBlock) -> Cell? {
        return TweetCell(tweetBlock: block, styles: TweetCellStyles())
    }
    
    func createCell(block: UnsupportedContentBlock) -> Cell? {
        return FallbackContentCell(fallbackContentBlock: block, styles: FallbackContentCellStyles())
    }
    
    func createCell(block: VimeoBlock) -> Cell? {
        return VimeoCell(vimeoBlock: block, styles: CellStyleFactory.vimeo(block))
    }
    
    func createCell(block: YoutubeBlock) -> Cell? {
        return YoutubeCell(youtubeBlock: block, styles: CellStyleFactory.youtube(block))
    }
}