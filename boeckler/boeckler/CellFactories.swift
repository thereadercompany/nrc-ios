//
//  CellFactories.swift
//  boeckler
//
//  Created by Emiel van der Veen on 23/11/15.
//  Copyright © 2015 TRC. All rights reserved.
//

import Foundation

extension ArticleRefBlock {
    func createCell() -> Cell? {
        switch style {
        case BlockStyle.Alert, BlockStyle.Breaking, BlockStyle.Highlight, BlockStyle.HighlightXL, BlockStyle.HighlightImage:
            return HighlightCell(articleRef: self)
        case BlockStyle.ColumnHighlight, BlockStyle.ColumnHighlightXL:
            return ColumnCell(articleRef: self)
        case BlockStyle.Normal, BlockStyle.Column:
            return NormalCell(articleRef: self)
        default:
            return nil
        }
    }
}

extension AlertBlock {
    func createCell() -> Cell? {
        return AlertCell(alertBlock: self)
    }
}

extension ArticleHeaderBlock {
    func createCell() -> Cell? {
        return ArticleHeaderCell(articleHeaderBlock: self)
    }
}

extension AuthorBlock {
    func createCell() -> Cell? {
        return nil
    }
}


extension BasicBannerBlock {
    func createCell() -> Cell? {
        return BasicBannerCell(bannerBlock: self)
    }
}

extension DividerBlock {
    func createCell() -> Cell? {
        return DividerCell(dividerBlock: self)
    }
}

extension EnhancedBannerBlock {
    func createCell() -> Cell? {
        return EnhancedBannerCell(bannerBlock: self)
    }
}

extension FallbackBlock {
    func createCell() -> Cell? {
        return FallbackContentCell(fallbackContentBlock: self)
    }
}

extension ImageBlock {
    func createCell() -> Cell? {
        return ImageCell(imageBlock: self)
    }
}

extension PlainTextBlock {
    func createCell() -> Cell? {
        switch style {
        case BlockStyle.H2, BlockStyle.InsetH1, BlockStyle.InsetH2:
            return PlainTextCell(plainTextBlock: self)
        default:
            return nil
        }
    }
}

extension ServerErrorBlock {
    func createCell() -> Cell? {
        return FallbackContentCell(fallbackContentBlock: self)
    }
}

extension SpacingBlock {
    func createCell() -> Cell? {
        switch (context,style) {
        case (.Article, BlockStyle.Normal), (.Article, BlockStyle.Inset):
            return SpacingCell(spacingBlock: self)
        case (.Timeline, _):
            return SpacingCell(spacingBlock: self)
        default:
            return nil
        }
    }
}

extension StreamerBlock {
    func createCell() -> Cell? {
        return StreamerCell(streamerBlock: self)
    }
}

extension TextBlock {
    func createCell() -> Cell? {
        switch style {
        case BlockStyle.Normal, BlockStyle.Inset, BlockStyle.Intro, BlockStyle.Byline:
            return TextCell(richTextBlock: self)
        default:
            return nil
        }
    }
}

extension TweetBlock {
    func createCell() -> Cell? {
        return TweetCell(tweetBlock: self)
    }
}

extension UnsupportedContentBlock {
    func createCell() -> Cell? {
        return FallbackContentCell(fallbackContentBlock: self)
    }
}

extension VimeoBlock {
    func createCell() -> Cell? {
        return VimeoCell(vimeoBlock: self)
    }
}

extension YoutubeBlock {
    func createCell() -> Cell? {
        return YoutubeCell(youtubeBlock: self)
    }
}

