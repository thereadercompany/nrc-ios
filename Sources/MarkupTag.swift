//
//  MarkupTag.swift
//  ios-nrc-nl
//
//  Created by Niels van Hoorn on 06/07/15.
//  Copyright (c) 2015 The Reader Company. All rights reserved.
//

import Foundation
import Argo

enum MarkupTag: String {
    case Author = "author"
    case Tagline = "tagline"
    case Keyword = "keyword"
    case TweetItem = "tweetitem"
    case QuotationMark = "quotationmark"
    case Phone = "phone"
    case P = "p"
    case A = "a"
    case Number = "number"
    case Header = "h1"
    case Subheader = "h2"
    case Strong = "strong"
    
    var font: UIFont {
        switch self {
        case .Tagline:
            return Fonts.mediumFont.fallbackWithSize(22)
        case .Keyword:
            return Fonts.defaultTaglineFont.fallbackWithSize(22)
        default:
            return Fonts.textFont.fallbackWithSize(16)
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .Keyword:
            return Colors.keywordFontColor
        case .Tagline:
            return Colors.taglineFontColor
        default:
            return Colors.defaultFontColor
        }
    }
}
