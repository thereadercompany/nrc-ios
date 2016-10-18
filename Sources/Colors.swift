//
//  Colors.swift
//  NRC
//
//  Created by Taco Vollmer on 18/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit

//MARK: - Colors
public struct Colors {
    static let placeholderColor = UIColor.lightGrayColor()
    static let accentColor = UIColor(hex: 0xD30910)
    static let accentColorDarker = Colors.accentColor.darker()
    static let iceBlue = UIColor(hex: 0xD3ECEE)
    static let sand = UIColor(hex: 0xEFEDE2)
    static let defaultBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let decorationBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let footerLineColor = accentColor
    
    static let cardBackgroundColor =  UIColor.whiteColor()
    static let statusViewBackgroundColor = UIColor.whiteColor()
    static let statusViewTextColor = Colors.accentColor
    static let articleBackgroundColor =  UIColor.whiteColor()
    static let timelineBackgroundColor =  UIColor(hex: 0x2A2D31)
    
    static let timelineSpacingBackgroundColor = Colors.accentColor
    static let imageBackgroundColor = UIColor(hex: 0xF6F6F6)
    
    static let twitterBlue = UIColor(hex: 0x55ACEE)
    static let callToAction = UIColor(hex:0x158B02)
    static let primairyButton = UIColor(hex:0x158B02)
    static let normalButton = UIColor.blackColor().colorWithAlphaComponent(0.6)
    static let normalButtonBorder = UIColor(hex:0x979797)
    static let defaultBackgroundColor = UIColor.whiteColor()
    static let defaultSpacingBackgroundColor = UIColor.clearColor()
    static let defaultFontColor = UIColor(hex: 0x2A2D31)
    static let titleOverImageColor = UIColor.whiteColor()
    static let titleOverImageBackgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    
    static let defaultLineColor = UIColor(hex: 0xBCBCBC)
    static let defaultShadowColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
    static let cardShadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    static let paywallButtonTitleColor = UIColor(hex: 0x158B02)
    static let paywallButtonBackgroundColor = UIColor(hex: 1411842)
    static let enhancedBannerRichTextBorder = UIColor.whiteColor().colorWithAlphaComponent(0.4)
    static let enhancedBannerRichTextBackground = normalButton
    static let transparant = UIColor.clearColor()
    static let dividerForegroundColor = UIColor(hex: 0xE6EAEE).colorWithAlphaComponent(0.4)
    static let dividerBackgroundColor = UIColor.whiteColor()
    static let navigationViewDarkBackgroundColor = accentColor
    static let navigationViewLightBackgroundColor = UIColor.whiteColor()
    static let navigationViewLightTitleColor = UIColor.blackColor()
    static let navigationViewDarkTitleColor = UIColor.whiteColor()
    static let navigationViewLightSubtitleColor = UIColor.blackColor()
    static let navigationViewDarkSubtitleColor = UIColor(hex: 0xA7A8A9)
    static let navigationViewTransparentBackgroundColor = UIColor.clearColor()
    static let navigationViewDividerColor = UIColor(hex: 0xD1D2D4)
    static let fallbackBackgroundColor = UIColor.whiteColor()
    static let overlayFontColor = UIColor.whiteColor()
    static let errorBackgroundColor = UIColor(hex: 0xE6EAEE)
    static let errorMessageTextColor = UIColor(hex: 0x2A2D31)
    static let errorActionButtonTextColor = UIColor(hex: 0xD30910)
    static let refreshControlTintColor = UIColor(hex: 0xE6EAEE)
    static let loadingIndicatorColor = UIColor.whiteColor()
    
    static let linkColor = nrcLinkColor
    
    //MARK: Image
    static let imageNodeBackgroundColor = UIColor(hex: 0xF6F6F6)
    
    //MARK: Inset
    static let insetBackgroundColor = UIColor.whiteColor()
    static let insetLineColor = UIColor(hex: 0xD6D6D6)
    
    //MARK: Label
    static let labelTextColor = UIColor(hex: 0x5E5E5E)
    static let labelBackgroundColor = UIColor.whiteColor()
    static let labelBorderColor = UIColor(hex: 0xB3B3B3)
    
    static let cellBackgroundColor = UIColor.whiteColor()
    
    //MARK: Tweet
    static let tweetBackgroundColor = Colors.cellBackgroundColor
    static let tweetBorderColor = UIColor(red: 204/255, green: 214/255, blue: 221/255, alpha: 1)
    static let tweetTextColor = UIColor(red: 28/255, green: 32/255, blue: 34/255, alpha: 1)
    static let tweetAuthorColor = UIColor(red: 105/255, green: 120/255, blue: 130/255, alpha: 1)
    static let tweetTimestampColor = tweetAuthorColor
    
    //MARK: Information
    static let articleInformationBackgroundColor = UIColor(hex: 0xEFEFEF)
    
    //MARK: Block Quote
    static let articleBlockQuoteBackgroundColor = nrcRedLight
    
    //MARK: Recommendation
    static let articleRecommendationBackgroundColor = UIColor(hex: 0xE6EDF2)
    
    //MARK: Markup
    static let keywordFontColor = nrcRed
    static let taglineFontColor = nrcRed
    
    //MARK: Quote
    static let quoteLineColor = UIColor(hex: 0x050303)
    
    //MARK: Divider
    static let dividerTextColor = UIColor(hex: 0xAAAAAA)
    static let dividerLineColor = UIColor(hex: 0xAAAAAA)
    
    //MARK: Buttons
    static let buttonBorderColor = UIColor(hex:0xC8C8C8)
    static let callToActionColor = UIColor(hex:0x158B02)
    static let normalButtonColor = UIColor.whiteColor()
    
    //MARK: Streamer
    static let streamerLineColor = UIColor(hex: 0x050303)
    
    //MARK - NRC
    static let nrcRed = UIColor(hex: 0xD20810)
    static let nrcRedLight = UIColor(hex: 0xFBE9E9)
    static let nrcTextColor = UIColor(hex: 0x191919)
    static let nrcLinkColor = UIColor(hex: 0x0b4f89)
    static let nrcAnthracite = UIColor(hex: 0x1A1A1A)
    static let nrcAnthraciteLightness70 = UIColor(hex: 0x676767)
    static let nrcAnthraciteLightness80 = UIColor(hex: 0x4d4d4d)
}
