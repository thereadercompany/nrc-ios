//
//  DTCSSStylesheet.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 10/08/15.
//  Copyright © 2015 The Reader Company. All rights reserved.
//

import Foundation
import DTCoreText
import NRCFonts

private func initializeDTCoreText() {
    registerFont(Fonts.textFont.name, bold: Fonts.boldTextFont.name, italic: Fonts.italicTextFont.name, boldItalic: Fonts.boldItalicTextFont.name)
    registerFont(Fonts.mediumFont.name)
    registerFont(Fonts.lightFont.name)
    registerFont(Fonts.alternativeTextFont.name, bold: Fonts.alternativeMediumFont.name, italic: Fonts.alternativeItalicFont.name)
}

private func registerFont(fontName: String, bold: String? = nil, italic: String? = nil, boldItalic: String? = nil) {
    DTCoreTextFontDescriptor.setOverrideFontName(fontName, forFontFamily: fontName, bold: false, italic: false)
    let boldName = bold ?? fontName
    DTCoreTextFontDescriptor.setOverrideFontName(boldName, forFontFamily: fontName, bold: true, italic: false)
    let italicName = italic ?? fontName
    DTCoreTextFontDescriptor.setOverrideFontName(italicName, forFontFamily: fontName, bold: false, italic: true)
    let boldItalicName = boldItalic ?? fontName
    DTCoreTextFontDescriptor.setOverrideFontName(boldItalicName, forFontFamily: fontName, bold: true, italic: true)
}

private let sharedDTCSSStyleSheet: DTCSSStylesheet = {
    initializeDTCoreText()
    var stylesheet = DTCSSStylesheet(styleBlock:
        "\(MarkupTag.Tagline.rawValue) {color: \(MarkupTag.Tagline.fontColor.hexString); font-family: \"\(Fonts.defaultTaglineFont.name)\"; font-weight: 100; } " +
        "\(MarkupTag.Keyword.rawValue) {color: \(MarkupTag.Keyword.fontColor.hexString); font-family: \"\(Fonts.defaultKeywordFont.name)\"; font-weight: 100; } " +
        "\(MarkupTag.Author.rawValue)  {color: \(MarkupTag.Author.fontColor.hexString); font-family: \"\(Fonts.defaultAuthorFont.name)\";  font-weight: 100; } " +
        "\(MarkupTag.P.rawValue)       {margin-bottom:0} " +
        "\(MarkupTag.A.rawValue)  {color: \(Colors.linkColor.hexString); text-decoration: none; } " +
        "\(MarkupTag.TweetItem.rawValue)  {color: \(Colors.twitterBlue.hexString); } " +
        "\(BlockStyle.Recommendation.rawValue) \(MarkupTag.A.rawValue) {text-decoration: none; color: \(Colors.defaultFontColor.hexString); font-family: \"\(Fonts.mediumFont.name)\";  font-weight: 600; }" +
        "\(BlockStyle.Recommendation.rawValue) \(MarkupTag.Strong.rawValue) {text-decoration: none; color: \(Colors.defaultFontColor.hexString); font-family: \"\(Fonts.lightFont.name)\";  font-weight: 400; }" +
        "\(MarkupTag.QuotationMark.rawValue) { font-family: \"\(Fonts.textFont.name)\"; font-size: \(33)px; font-weight: normal; }" +
        "\(MarkupTag.Header.rawValue),\(MarkupTag.Subheader.rawValue) { margin: 0; display: inherit; }" +
        "\(MarkupTag.Number.rawValue) { font-family: \"\(Fonts.alternativeTextFont.name)\"; font-size: \(ArticleStyles.numberFontSize); line-height: 1.1; font-weight: bold; color: \(ArticleStyles.numberFontColor.hexString) }"
    )
    return stylesheet
}()

extension DTCSSStylesheet {
    static var shared: DTCSSStylesheet {
        return sharedDTCSSStyleSheet
    }
}
