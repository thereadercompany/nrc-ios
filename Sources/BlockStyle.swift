//
//  BlockStyle.swift
//  NRC
//
//  Created by Taco Vollmer on 18/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import Core

/** Defines all available styles in this project. In `Core` these are represented by a `String` in the `Renderable` protocol */
enum BlockStyle: String {
    case Large = "large"
    case Medium = "medium"
    case Small = "small"
    case Normal = "normal"
    
    case ColumnLarge = "column-large"
    case ColumnSmall = "column-small"
    
    case Recommendation = "recommendation"
    case BlockQuote = "block-quote"
    case Information = "information"
    
    case Header = "h1"
    case Subheader = "h2"
    case XL = "xl"
    case Quote = "quote"
    case Intro = "intro"
    case Byline = "byline"
    case Image = "image"
    case Inset = "inset"
    case InsetHeader = "inset-h1"
    case InsetSubheader = "inset-h2"
    case ArticleFooter = "article-footer"
    
    // user for video node when playing animated gif
    case AnimatedGIF = "animated-gifs"
    
    case Unknown = "unknown"
    
    init(style: String) {
        self = BlockStyle(rawValue: style) ?? .Unknown
    }
}

extension Renderable {
    /** Converts the `Core` style `String` to `BlockStyle` */
    var blockStyle: BlockStyle {
        return BlockStyle(style: style)
    }
}
