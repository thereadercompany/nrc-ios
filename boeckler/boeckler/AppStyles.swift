//
//  AppStyles.swift
//  ios-nrc-nl
//
//  Created by Niels van Hoorn on 19/08/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import DTCoreText
import NRCFonts

extension BlockStyle {
    static let Normal = BlockStyle(rawValue: "normal")
    static let Column = BlockStyle(rawValue: "column")
    static let ColumnHighlight = BlockStyle(rawValue: "column-highlight")
    static let ColumnHighlightXL = BlockStyle(rawValue: "column-highlight-xl")
    static let Breaking = BlockStyle(rawValue: "breaking")
    static let Highlight = BlockStyle(rawValue: "highlight")
    static let HighlightXL = BlockStyle(rawValue: "highlight-xl")
    static let HighlightImage = BlockStyle(rawValue: "depricated")
    static let Alert = BlockStyle(rawValue: "alert")
    static let H1 = BlockStyle(rawValue: "h1")
    static let H2 = BlockStyle(rawValue: "h2")
    static let XL = BlockStyle(rawValue: "xl")
    static let Quote = BlockStyle(rawValue: "quote")
    static let Intro = BlockStyle(rawValue: "intro")
    static let Byline = BlockStyle(rawValue: "byline")
    static let Inset = BlockStyle(rawValue: "inset")
    static let InsetH1 = BlockStyle(rawValue: "inset-h1")
    static let InsetH2 = BlockStyle(rawValue: "inset-h2")
    static let Unknown = BlockStyle(rawValue: "unknown")
}


struct Colors {
    static let accentColor = UIColor(hex: 0xD30910)
    static let linkColor = UIColor(hex: 0xD30910)
    static let cardBackgroundColor =  UIColor.whiteColor()
    static let articleBackgroundColor =  UIColor.whiteColor()
    static let timelineBackgroundColor =  accentColor
    static let timelineDividerBackgroundColor = UIColor.clearColor()
    static let timelineSpacingBackgroundColor = UIColor.clearColor()
    static let insetBackgroundColor = UIColor(hex: 0xF7F7F7)
    static let tweetTextColor = UIColor(hex: 0x3E4447)
    static let tweetSubHeadlineColor = UIColor(hex: 0xB1B4B5)
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
    static let insetLineColor = UIColor(hex: 0xE6EAEE)
    static let defaultLineColor = UIColor(hex: 0xE6EAEE)
    static let defaultShadowColor = UIColor.blackColor().colorWithAlphaComponent(0.35)
    static let cardShadowColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
    static let paywallButtonTitleColor = UIColor.whiteColor()
    static let paywallButtonBackgroundColor = UIColor(hex: 1411842)
    static let enhancedBannerRichTextBorder = UIColor.whiteColor().colorWithAlphaComponent(0.4)
    static let enhancedBannerRichTextBackground = normalButton
    static let transparant = UIColor.clearColor()
    static let dividerForegroundColor = UIColor(hex: 0xE6EAEE).colorWithAlphaComponent(0.4)
    static let dividerBackgroundColor = UIColor.clearColor()
    static let navigationViewDarkBackgroundColor = accentColor
    static let navigationViewLightBackgroundColor = UIColor(hex: 0xFAF9F5)
    static let navigationViewLightTitleColor = UIColor.blackColor()
    static let navigationViewDarkTitleColor = UIColor.whiteColor()
    static let navigationViewLightSubtitleColor = UIColor.blackColor()
    static let navigationViewDarkSubtitleColor = UIColor(hex: 0xA7A8A9)
    static let navigationViewTransparentBackgroundColor = UIColor.clearColor()
    static let navigationViewDividerColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    static let fallbackBackgroundColor = UIColor.yellowColor()
    static let overlayFontColor = UIColor.whiteColor()
    static let labelTextColor = UIColor.whiteColor()
    static let taglineFontColor = UIColor(hex: 0xD30910)
    static let enhancedBannerFontColor = UIColor.whiteColor()
    static let errorBackgroundColor = UIColor(hex: 0xE6EAEE)
    static let errorMessageTextColor = UIColor(hex: 0x2A2D31)
    static let errorActionButtonTextColor = UIColor(hex: 0xD30910)
    static let refreshControlTintColor = UIColor(hex: 0xE6EAEE).colorWithAlphaComponent(0.6)
    static let loadingIndicatorColor = UIColor.whiteColor()
    static let imageBackgroundColor = UIColor(hex: 0xF6F6F6)
}

struct Fonts {
    static let textFont:Font = UniversNextPro.Regular
    static let regularFont:Font = UniversNextPro.Regular
    static let mediumFont:Font = UniversNextPro.BoldCond
    static let largeFont:Font = UniversNextPro.BoldCond
    static let lightFont:Font = UniversNextPro.Regular
    static let alternativeTextFont: Font = SimpleHBS.Regular
    static let alternativeMediumFont: Font = SimpleHBS.Regular
    static let defaultTaglineFont: Font = UniversNextPro.BoldCond
    static let defaultAuthorFont: Font = SimpleHBS.Regular
    static let tweetFont = HelveticaNeue.Light
    static let tweetHeadlineFont = HelveticaNeue.Medium
    
    static let fallbackUIFont = UIFont.systemFontOfSize(14)
    
    static func load() throws {
        try NRCFonts.Loader.loadFontsIfNeeded([UniversNextPro.Regular, UniversNextPro.BoldCond, SimpleHBS.Regular])
    }

    enum HelveticaNeue: String, Font {
        static let family = "Helvetica"
        static let style = "Neue"
        case Light
        case Medium
    }
    
    enum SimpleHBS: String, Font {
        static let family = "SimpleHBS"
        case Regular
    
        var name: String {
            return "SimpleHBS"
        }
    }
    
    enum UniversNextPro: String, Font {
        static let family = "UniversNextPro"
        case Regular
        case BoldCond
    }
}

extension Font {
    func optionalWithSize(size: CGFloat) -> UIFont? {
        do {
            return try self.withSize(size)
        } catch {
            print("Error loading font \(self.name):",error)
            return nil
        }
    }

    func fallbackWithSize(size: CGFloat) -> UIFont {
        return optionalWithSize(size) ?? Fonts.fallbackUIFont
    }
}

struct TimelineStyles {
    static let enablePullToRefresh = false
    static let topInset: CGFloat = 0
    static let defaultMargin: CGFloat = 0
    static let internalMargin: CGFloat = 16
    static let contentInset: CGFloat = 16
    static let backgroundColor = Colors.timelineBackgroundColor
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar
    static let lineInset: CGFloat = 16
    static let lineHeight: CGFloat = 1
    static let initiallyHideNavigationView = true
    static let navigationViewStyle = NavigationViewStyle.Dark
    static func navigationViewNeedsLine(style: NavigationViewStyle) -> Bool {
        return true
    }
    static func navigationTextVisible(style: NavigationViewStyle) -> Bool {
        switch style {
        case .Transparent, .Dark:
            return false
        case .Light:
            return true
        }
    }
    static func imageForTimelineDecoration(decoration: BlockDecoration, imagePosition: BlockDecoration? = BlockDecoration.None) -> UIImage? {
        return nil
    }
    
    static func preferredStatusBarStyle(navStyle: NavigationViewStyle) -> UIStatusBarStyle {
        switch navStyle {
        case .Dark:
            return .LightContent
        case .Transparent, .Light:
            return .Default
        }
    }
}

struct ArticleStyles {
    static let topInset: CGFloat = 0
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar    
    static let textInset: CGFloat = 24
    static let backgroundColor = Colors.articleBackgroundColor
    static func navigationViewNeedsLine(style: NavigationViewStyle) -> Bool {
        return style == .Light
    }
}

struct ArticleHeaderCellStyles {
    static let imageHeight: CGFloat = Window.vval([Screen.vXS: Screen.vXS*(5/12),Screen.vS:Screen.vS*(5/12),Screen.vM:Screen.vM*(6/12), Screen.vL:Screen.vL*7/12])
    static let headlineMarginTop: CGFloat = 40
}

struct DividerCellStyles {
    static let lineHeight: CGFloat = 0.5
    static let textMargin: CGFloat = 12
}

struct SpacingCellStyles {
    static let topShadowSize: CGFloat = 0
    static let topShadowAlpha: CGFloat = 0.4
    static let bottomShadowSize: CGFloat = 0
    static let bottomShadowAlpha: CGFloat = 0.4
}

struct NormalCellStyles {
    static let imageBottomPadding: CGFloat = 6
    static let bulletInsetTop: CGFloat = 4
    static let lineInset: CGFloat = 4
    static let lineMarginTop: CGFloat = 12
    static let textInset: CGFloat = 14
    static let imageInsets = CGPoint(x: 25, y: 11)
    static let imageSize: CGFloat = 48
}

struct ColumnCellStyles {
    static let headlineLinespacing: CGFloat = 2
    static let authorFont = Fonts.lightFont.fallbackWithSize(17)
    static let authorLinespacing: CGFloat = 3
    static let headlineBottomMargin: CGFloat = -3
    static let richTextTopMargin: CGFloat = 19
    static let imageInsets = CGPoint(x: 16, y: 17)
    static let imageSize: CGFloat = 56
    static let lineHeight: CGFloat = 1
}

struct HighlightCellStyles {
    static let pushAnimationDuration: NSTimeInterval = 0.45
    static let pushAnimationFadeInDuration: NSTimeInterval = 0.2
    static let popAnimationDuration: NSTimeInterval = 0.34
    static let popAnimationDurationXL: NSTimeInterval = 0.4
    static let maximumLineCount: UInt = 3
    static let headlineMarginTop: CGFloat = 18
    static let richTextMarginTop: CGFloat = 6
    static let richTextInset: CGFloat = 12
    static let breakingHeadlineMarginTop: CGFloat = 24
    static let breakingRichTextMarginTop: CGFloat = 16
    static let height: CGFloat = Window.hval([Screen.hS:306,Screen.hM:342,Screen.hL:367])
    static func roundedImageCorners() -> UIRectCorner {
        return []
    }
    
    static func gradientPositions(style: BlockStyle) -> [GradientPosition] {
        switch style {
        case BlockStyle.HighlightXL:
            return [.Top(0.2, 0.7), .Left(0.8, 1), .Bottom(0.5, 0.7)]
        default:
            return [.Bottom(0.5, 0.7)]
        }
    }
}

struct AlertCellStyles {
    static let headlineMarginTop: CGFloat = 18
    static let plainTextMarginTop: CGFloat = 10
}

struct EnhancedBannerCellStyles {
    static let labelMarginTop: CGFloat = 24
    static let labelMarginBottom: CGFloat = 28
    static let contentInset: CGFloat = 20
    static let subHeadlineMarginTop: CGFloat = 18
    static let subHeadlineMarginBottom: CGFloat = 6
    static let buttonMarginInternal: CGFloat = 12
    static let buttonMarginTop: CGFloat = 24
    static let buttonMarginTopXL: CGFloat = Window.vval([Screen.vXS:22,Screen.vS:22,Screen.vM:34,Screen.vL:50])
    static let buttonMarginBottom: CGFloat = 28
    static let buttonMarginBottomXL: CGFloat = Window.vval([Screen.vXS:28,Screen.vS:28,Screen.vM:40,Screen.vL:56])
    static let richTextMarginTop: CGFloat = Window.vval([Screen.vXS:28,Screen.vS:28,Screen.vM:40,Screen.vL:56])
    static let richTextMarginBottom: CGFloat = 28
    static let richTextMarginBottomXL: CGFloat = Window.vval([Screen.vXS:52,Screen.vS:52,Screen.vM:64,Screen.vL:80])
    static let headlineMarginBottomXL: CGFloat = Window.vval([Screen.vXS:14,Screen.vS:14,Screen.vM:26,Screen.vL:40])
    static let contentWidth: CGFloat = 272
}

extension MediaCell {
    override func layout() {
        super.layout()
        imageNode.frame = self.bounds
        layoutGradients()
    }
}

extension HighlightCell {
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        switch block.style {
        case BlockStyle.HighlightXL:
            return CGSize(width: constrainedSize.width, height: constrainedSize.width)
        default:
            return CGSize(width: constrainedSize.width, height: constrainedSize.width*(256/375))
        }
    }
    
    override func layout() {
        super.layout()
        issueLabelNode.frame = issueLabelRect
        issueLabelNode.hidden = !articleRef.shouldRenderIssueLabel
        labelNode.frame = labelRect
        labelNode.hidden = !articleRef.shouldRenderLabel
        let contentRect = frame.insetsBy(block.contentPadding)
        
        // reading time 
        let readingTimeSize = self.readingTimeSize(contentRect.width)
        let readingTimeOrigin = CGPoint(x: CGRectGetMaxX(labelNode.frame)+10, y: labelNode.frame.origin.y+((labelNode.frame.height-readingTimeSize.height)*3/5))
        readingTimeNode.frame = CGRect(origin: readingTimeOrigin, size: readingTimeSize)
        
        // headline
        let headlineSize = self.headlineSize(contentRect.width)
        
        // position headline on top of image (z-axis)
        let headerlineOriginY = labelNode.frame.origin.y - headlineSize.height - 4
        self.headlineNode.frame = CGRect(origin: CGPoint(x: contentRect.origin.x, y: headerlineOriginY), size: headlineSize)
    }
    
    var labelRect: CGRect {
        let contentRect = frame.insetsBy(block.contentPadding)
        let size = labelNode.measure(CGSize(width: CGFloat.max, height: CGFloat.max))
        let origin = CGPoint(x:contentRect.origin.x+1, y:frame.height-articleRef.contentPadding.bottom-size.height-articleRef.labelInset.y)
        return CGRect(origin: origin, size: size)
    }
    
    var issueLabelRect: CGRect {
        let contentRect = frame.insetsBy(block.contentPadding)
        let size = issueLabelNode.measure(CGSize(width: CGFloat.max, height: CGFloat.max))
        let origin = CGPoint(x:contentRect.origin.x+1, y:contentRect.origin.y)
        return CGRect(origin: origin, size: size)
    }
}

extension EnhancedBannerBlock {
    var gradientStartLocation: CGFloat {
        switch style {
        case BlockStyle.XL:
            return 0.6
        default:
            return 0.35
        }
    }
    
    var gradientStartAlpha: CGFloat {
        switch style {
        case BlockStyle.XL:
            return 0.5
        default:
            return 0.8
        }
    }
    
    var headlineMarginBottom: CGFloat {
        switch style {
        case BlockStyle.XL where shouldRenderRichText:
            return EnhancedBannerCellStyles.headlineMarginBottomXL
        default:
            return 0
        }
    }
    
    var richTextMarginBottom: CGFloat {
        switch style {
        case BlockStyle.XL:
            return EnhancedBannerCellStyles.richTextMarginBottomXL
        default:
            return EnhancedBannerCellStyles.richTextMarginBottom
        }
    }

    var buttonMarginTop: CGFloat {
        switch style {
        case BlockStyle.XL:
            return EnhancedBannerCellStyles.buttonMarginTopXL
        default:
            return EnhancedBannerCellStyles.buttonMarginTop
        }
    }
    
    var buttonMarginBottom: CGFloat {
        switch style {
        case BlockStyle.XL:
            return EnhancedBannerCellStyles.buttonMarginBottomXL
        default:
            return EnhancedBannerCellStyles.buttonMarginBottom
        }
    }
    
    func applyRichTextStyle(textNode: LabelNode) {
        switch style {
            case BlockStyle.XL:
                let insets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
                let backgroundColor = Colors.enhancedBannerRichTextBackground
                let borderColor = Colors.enhancedBannerRichTextBorder
                textNode.applyStyle(insets, backgroundColor:backgroundColor, borderColor: borderColor, cornerRadius: 2)
            default:
                textNode.applyStyle(UIEdgeInsetsZero, cornerRadius: 2)
        }
    }
}

struct StreamerCellStyles {
    static let headlineMarginTop: CGFloat = 28
    static let headlineMarginBottom: CGFloat = 12
    static let subHeadlineMarginTop: CGFloat = 14
    static let subHeadlineMarginBottom: CGFloat = 25
    static let topMargin: CGFloat = 8
    static let bottomMargin: CGFloat = 38
    static let lineHeight: CGFloat = 4
}

struct TweetCellStyles {
    static let headlineLeftMargin: CGFloat = 8
    static let richTextLeftMargin: CGFloat = 20
    static let imageSize: CGFloat = 36
    static let twitterLogoSize = CGSize(width: 17, height: 14)
    static let topPadding: CGFloat = 20
    static let richTextTopMargin: CGFloat = 8
    static let bottomPadding: CGFloat = 26
    static let defaultAspectRatio: Float = 4/3
}
    
struct ImageCellStyles {
    static let textPaddingTop: CGFloat = 20
}

struct VideoCellStyles {
    static let headlinePaddingBottom: CGFloat = 12
    static let headlinePaddingLeftRight: CGFloat = 24
    static let gradientAspectRatio: CGFloat = 3.9
    static let playImageOffcentrePercentage: CGFloat = 5
}

struct LabelStyles {
    static let linespacing: CGFloat = 3
    static let color = Colors.labelTextColor
    static let labelInset = CGPoint(x: 16, y: 12)
    static let labelTextInsets = UIEdgeInsets(top: 1, left: 6, bottom: 1, right: 6)
}

struct IssueLabelStyles {
    static let backgroundColor = Colors.transparant
    static let foregroundColor = Colors.titleOverImageColor
    static let lineHeight: CGFloat = 2
    static let font = Fonts.alternativeMediumFont.fallbackWithSize(24)
}

struct ErrorStyles {
    static let font = Etica.SemiBold
    static let messageFont = font.optionalWithSize(14)
    static let buttonFont = font.optionalWithSize(14)
}

extension NavigationViewStyle {
    var backgroundColor: UIColor {
        switch self {
        case .Transparent:
            return Colors.navigationViewTransparentBackgroundColor
        case .Dark:
            return Colors.navigationViewDarkBackgroundColor
        case .Light:
            return Colors.navigationViewLightBackgroundColor
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .Transparent, .Dark:
            return Colors.navigationViewDarkTitleColor
        case .Light:
            return Colors.navigationViewLightTitleColor
        }
    }
    
    var subtitleColor: UIColor {
        switch self {
        case .Transparent, .Dark:
            return Colors.navigationViewDarkSubtitleColor
        case .Light:
            return Colors.navigationViewLightSubtitleColor
        }
    }
    
    var titleFont: UIFont {
        return Fonts.alternativeMediumFont.fallbackWithSize(16)
    }
    
    var subtitleFont: UIFont? {
        return Fonts.alternativeTextFont.fallbackWithSize(11)
    }
    
    var autoHideDelay: NSTimeInterval? {
        return 2
    }
}

extension BlockDecoration {
    var roundedCorners: UIRectCorner {
        switch self {
        case .Full:
            return UIRectCorner.AllCorners
        case .Top:
            return [UIRectCorner.TopLeft, UIRectCorner.TopRight]
        case .Bottom:
            return [UIRectCorner.BottomLeft, UIRectCorner.BottomRight]
        default:
            return UIRectCorner()
        }
    }
    
    var cardDecorationPaddingBottom: CGFloat {
        switch self {
        case .Bottom, .Full: return 16
        default: return 0
        }
    }
    
    var insetDecorationPaddingBottom: CGFloat {
        switch self {
        case .Bottom, .Full: return 68
        default: return 0
        }
    }
    
    var tweetDecorationPaddingBottom: CGFloat {
        switch self {
        case .Bottom, .Full: return 24
        default: return 0
        }
    }
}

extension UIView {
    func drawFullCardDecoration() {
        alpha = 1
        layer.cornerRadius = 2
        layer.shadowColor = Colors.cardShadowColor.CGColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
    }
}

extension BlockType {
    
    var decorationPaddingSide: CGFloat {
        switch (self.context, self.dynamicType.type) {
        case (.Article, .Tweet):
            return 24
        default:
            return 0
        }
    }
    
    var decorationPaddingBottom: CGFloat {
        switch (self.context, self.dynamicType.type, style) {
        case (.Article, .Tweet, _):
            return self.decoration.tweetDecorationPaddingBottom
        case (.Article, .Image, _):
            return self.decoration.insetDecorationPaddingBottom
        default:
            return 0
        }
    }
    
    var decorationPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: decorationPaddingSide, bottom: decorationPaddingBottom, right: decorationPaddingSide)
    }
    
    func drawFullDecoration(view: UIView) {
        // currently not used
    }
        
    var contentPadding: UIEdgeInsets {
        let decorationPadding = self.decorationPadding

        var contentPadding: UIEdgeInsets
        switch (self.context, self.dynamicType.type, style) {
        case (.Timeline, .ArticleRef, BlockStyle.Normal):
            contentPadding =  UIEdgeInsets(top: 19, left: 12, bottom: 0, right: 19)
        case (.Timeline, .ArticleRef, BlockStyle.Highlight),
             (.Timeline, .ArticleRef, BlockStyle.HighlightXL),
             (.Timeline, .ArticleRef, BlockStyle.Breaking),
             (.Timeline, .ArticleRef, BlockStyle.Alert):
             contentPadding =  UIEdgeInsets(top: 19, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (.Timeline, .ArticleRef, BlockStyle.ColumnHighlight),
            (.Timeline, .ArticleRef, BlockStyle.ColumnHighlightXL):
            contentPadding =  UIEdgeInsets(top: 20, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (_, .EnhancedBanner, _), (_, .BasicBanner, _):
            contentPadding = UIEdgeInsetsZero
        case (_, .Divider, _):
            contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        case (_, .Tweet, _):
            contentPadding = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        case (_, .Image, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 68, right: ArticleStyles.textInset)
        case (_, .UnsupportedContent, _),(_, .Fallback, _):
            contentPadding = UIEdgeInsets(top: 20, left: ArticleStyles.textInset, bottom: 20, right: ArticleStyles.textInset)
        case (.Timeline, _, _):
            contentPadding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (.Article, _, BlockStyle.Intro), (.Article, _, BlockStyle.Byline):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 31, right: ArticleStyles.textInset)
        case (.Article, .Streamer, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 40, right: ArticleStyles.textInset)
        case (.Article, .ArticleHeader, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 25, right: ArticleStyles.textInset)
        case (.Article, _, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 24, right: ArticleStyles.textInset)
        default:
            contentPadding = UIEdgeInsetsZero
        }
        
        var result = UIEdgeInsets()
        result.top = decorationPadding.top + contentPadding.top
        result.left = decorationPadding.left + contentPadding.left
        result.bottom = decorationPadding.bottom + contentPadding.bottom
        result.right = decorationPadding.right + contentPadding.right
        return result
    }
    
    
    var lineColor: UIColor {
        switch (self.dynamicType.type, style ) {
        case (.ArticleRef, _):
            return Colors.defaultLineColor
        case (_, BlockStyle.Inset):
            return Colors.insetLineColor
        default:
            return Colors.defaultLineColor;
        }
    }
    
    var backgroundColor: UIColor {
        switch (context, self.dynamicType.type, style) {
        case (_, _, BlockStyle.Inset), (_, _, BlockStyle.InsetH1), (_, _, BlockStyle.InsetH2):
            return Colors.insetBackgroundColor
        case (.Timeline, .Divider, _):
            return Colors.timelineDividerBackgroundColor
        case (.Timeline, .Spacing, _):
            return Colors.timelineSpacingBackgroundColor
        case (.Timeline, _, _):
            return Colors.cardBackgroundColor
        case (.Article, _, _):
            return Colors.articleBackgroundColor
        default:
            return Colors.defaultBackgroundColor
        }
    }
    
    var uiFont: UIFont {
        return font.fallbackWithSize(fontSize)
    }
    
    var font: Font {
        switch (self.dynamicType.type, style) {
        case (.Text, BlockStyle.Byline), (_, BlockStyle.Inset), (.Image, _):
            return Fonts.alternativeTextFont
        case (.Text, BlockStyle.Intro):
            return Fonts.lightFont
        case (_,BlockStyle.InsetH1), (_,BlockStyle.InsetH2), (.EnhancedBanner, _):
            return Fonts.alternativeMediumFont
        case (_,BlockStyle.H2):
            return Fonts.mediumFont
        case (.Tweet, _):
            return Fonts.tweetFont
        default:
            return Fonts.textFont
        }
    }
    
    var fontColor: UIColor {
        switch (self.dynamicType.type, style) {
        case (.Text, BlockStyle.Byline):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.6)
        case (_, BlockStyle.Inset),(.Image, _):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.8)
        case (_, BlockStyle.InsetH1):
            return Colors.accentColor
        case (.Tweet, _):
            return Colors.tweetTextColor
        case (.EnhancedBanner, _):
            return Colors.overlayFontColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var fontSize: CGFloat {
        switch style {
        case BlockStyle.Inset:
            return 16
        case BlockStyle.InsetH1:
            return 14
        case BlockStyle.InsetH2:
            return 16
        case BlockStyle.Intro:
            return 22
        case BlockStyle.Byline:
            return 14
        case BlockStyle.H2:
            return 20
        case BlockStyle.Column:
            return 26
        default:
            return 16
        }
    }
    
    var lineSpacing: CGFloat {
        switch (self.dynamicType.type, style) {
        case (.Text, BlockStyle.Intro):
            return 6
        case (.Text, BlockStyle.Byline):
            return 4
        case (.Text, BlockStyle.H2):
            return 4
        case (_, BlockStyle.Inset):
            return 3
        case (_, BlockStyle.InsetH1):
            return 4
        case (_, BlockStyle.InsetH2):
            return 6
        case (.Image, _):
            return 3
        case (.Tweet, _):
            return 3
        case (.EnhancedBanner, _):
            return 0
        default:
            return 11
        }
    }
    
    var imageRatio: CGFloat {
        switch style {
        case BlockStyle.Breaking:
            return 3/2
        default:
            return 16/9
        }
    }
    
    var paddingTop: CGFloat {
        switch (self.dynamicType.type, style) {
        case (.Text, BlockStyle.H2):
            return 8+6
        case (.ArticleHeader, _):
            return 32
        default:
            return 0
        }
    }
    
    var paddingBottom: CGFloat {
        switch (self.dynamicType.type, style) {
        case ( _, BlockStyle.Intro):
            return 32
        case ( _, BlockStyle.Byline):
            return 32
        case ( _, BlockStyle.H2):
            return 8+6
        case ( _, BlockStyle.InsetH1):
            return 24
        case ( _, BlockStyle.InsetH2):
            return 8
        case ( .ArticleHeader, _):
            return 24+6
        case (.Youtube, _), (.Vimeo, _):
            return 40
        default:
            return 24
        }
    }
}

extension MarkupTag {
    var font: UIFont {
    switch self {
        case .Tagline:
            return Fonts.mediumFont.fallbackWithSize(22)
        default:
            return Fonts.textFont.fallbackWithSize(16)
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .Tagline:
            return Colors.taglineFontColor
        default:
            return Colors.defaultFontColor
        }
    }
}

private let tweetDateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "d/MM/yy"
    return formatter
    }()

extension DateContainable {
    var tweetStyleDate: String {
        guard let date = self.date else { return "" }
        return tweetDateFormatter.stringFromDate(date)
    }
}

extension IssueLabelContainable {
    
    var issueLabelInset: CGPoint {
        return CGPoint(x: 19, y: 19)
    }
    
    var shouldRenderIssueLabel: Bool {
        guard let issueLabel = issueLabel else { return false }
        return !issueLabel.isEmpty
    }
    
    var issueLabelFont: UIFont {
        return IssueLabelStyles.font
    }
    
    var issueLabelTextColor: UIColor {
        return IssueLabelStyles.foregroundColor
    }
    
    var issueLabelTextLineSpacing: CGFloat {
        return 0
    }
    
    func attributedIssueLabel() -> NSAttributedString {
        guard let issueLabel = self.issueLabel else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: issueLabelFont, foregroundColor: issueLabelTextColor, lineSpacing: issueLabelTextLineSpacing, alignment: NSTextAlignment.Center)
        let result = NSMutableAttributedString(string:issueLabel, attributes:attrs.dictionary)
        return result;
    }
}

extension LabelContainable {
    
    var labelCornerRadius: CGFloat {
       return 0
    }
    
    var labelInset: CGPoint {
        switch self.dynamicType.type {
        case .EnhancedBanner:
            return CGPoint(x: 19, y: 16)
        default:
            return CGPoint(x: 19, y: 23)
        }
    }
    
    var labelTextInsets: UIEdgeInsets {
        switch self.dynamicType.type {
        case .EnhancedBanner:
            return UIEdgeInsets(top: 14, left: 0, bottom: 15, right: 0)
        default:
            return UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        }
    }
    
    var shouldRenderLabel: Bool {
        guard let label = label else { return false }
        return !label.isEmpty
    }
    
    var labelFont: UIFont {
        switch self.dynamicType.type {
        case .EnhancedBanner:
            return Fonts.alternativeMediumFont.fallbackWithSize(16)
        default:
            return Fonts.alternativeMediumFont.fallbackWithSize(11)
        }
    }
    
    var labelTextColor: UIColor {
        switch self.dynamicType.type {
        case .Divider:
            return Colors.dividerForegroundColor
        default:
            return Colors.labelTextColor
        }
    }
    
    var labelTextLineSpacing: CGFloat {
        return 0
    }

    func attributedLabel() -> NSAttributedString {
        guard let label = self.label else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: labelFont, foregroundColor: labelTextColor, lineSpacing: labelTextLineSpacing, alignment: NSTextAlignment.Center)
        let result = NSMutableAttributedString(string:label, attributes:attrs.dictionary)
        return result;
    }
}

private let defaultAspectRatio: CGFloat = 4/3

extension MediaContainable {
    var shouldRenderImage: Bool {
        guard let media = self.media where !media.identifier.isEmpty else { return false }
        return true
    }
    
    func mediaHeightForWidth(width: CGFloat) -> CGFloat {
        guard let aspectRatio = self.media?.aspectRatio else { return round(width / defaultAspectRatio) }
        return round(width / CGFloat(aspectRatio))
    }
    
    var mediaBackgroundColor: UIColor {
        switch self.dynamicType.type {
        case .Image:
            return Colors.imageBackgroundColor
        default:
            return backgroundColor
        }
    }
}

extension HeadlineContainable {
    
    var headlineBackgroundColor: UIColor? {
        switch (context, self.dynamicType.type, style) {
        case (.Timeline, _, BlockStyle.HighlightImage):
            return Colors.titleOverImageBackgroundColor
        default:
            return nil
        }
    }
    
    var headlineFontColor: UIColor {
        switch (context, self.dynamicType.type, style) {
        case (.Timeline, _, BlockStyle.Highlight), (.Timeline, _, BlockStyle.HighlightXL):
            return Colors.titleOverImageColor
        case (.Article, .Streamer, _):
            return Colors.accentColor
        case (_, .Youtube, _), (_, .Vimeo, _), (_, .EnhancedBanner, _), (_, .UnsupportedContent, _), (_, .Fallback, _):
            return Colors.overlayFontColor
        case (_, .Tweet, _):
            return Colors.tweetTextColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var headlineFont: UIFont {
        switch (context, self.dynamicType.type, style) {
        case (.Timeline, .ArticleRef, BlockStyle.Highlight):
            return Fonts.mediumFont.fallbackWithSize(24)
        case (.Timeline, .ArticleRef, BlockStyle.HighlightXL):
            return Fonts.mediumFont.fallbackWithSize(34)
        case (.Article, .ArticleHeader,_):
            return Fonts.mediumFont.fallbackWithSize(36)
        case (.Article, .Streamer, _):
            return Fonts.regularFont.fallbackWithSize(24)
        case (_, .Youtube, _), (_, .Vimeo, _):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (.Article, .UnsupportedContent, _),(.Article, .Fallback, _):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (.Article, .Tweet, _):
            return Fonts.tweetHeadlineFont.fallbackWithSize(15)
        default:
            return Fonts.mediumFont.fallbackWithSize(22)
        }
    }
    
    var headlineLinespacing: CGFloat {
        switch (context, self.dynamicType.type, style) {
        case (.Timeline, _, BlockStyle.Highlight):
            return 4
        case (.Timeline, _, BlockStyle.HighlightXL):
            return 4
        case (.Timeline, _, BlockStyle.Normal):
            return 3
        case (.Article, .Streamer, _ ):
            return 7
        case (_, .Youtube, _), (_, .Vimeo, _):
            return 3
        case (.Article, _,  _):
            return 7
        default:
            return 3
        }
    }
    
    var headlineAlignment: NSTextAlignment {
        switch self.dynamicType.type {
        case .EnhancedBanner, .UnsupportedContent, .Fallback :
            return NSTextAlignment.Center
        default:
            return NSTextAlignment.Left
        }
    }
    
    var headlineShadow: NSShadow? {
        if !shouldRenderShadow { return nil }
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = Colors.defaultShadowColor
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        return shadow
    }
    
    var attributedHeadline: NSAttributedString {
        guard let headline = self.headline else { return NSAttributedString() }
        let attrs = StringAttributes(font: headlineFont, foregroundColor: headlineFontColor, backgroundColor: headlineBackgroundColor, lineSpacing: headlineLinespacing, alignment: headlineAlignment, shadow: headlineShadow)
        return NSMutableAttributedString(string:headline, attributes:attrs.dictionary)
    }
    
    var shouldRenderShadow: Bool {
        return true
    }
}

extension SubHeadlineContainable {
    
    var shouldRenderSubHeadline: Bool {
        guard let subHeadline = self.subHeadline else { return false }
        return !subHeadline.isEmpty
    }

    var subHeadlineFontColor: UIColor {
        switch self.dynamicType.type {
        case .Tweet:
            return Colors.tweetSubHeadlineColor
        case .EnhancedBanner:
            return Colors.enhancedBannerFontColor
        case .UnsupportedContent, .Fallback:
            return Colors.overlayFontColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var subHeadlineFont: UIFont {
        switch self.dynamicType.type {
        case .Tweet:
            return Fonts.tweetFont.fallbackWithSize(15)
        case .EnhancedBanner:
            return Fonts.lightFont.fallbackWithSize(20)
        case .UnsupportedContent, .Fallback:
            return Fonts.alternativeTextFont.fallbackWithSize(13)
        default:
            return Fonts.alternativeMediumFont.fallbackWithSize(14)
        }
    }
    
    var subHeadlineLinespacing: CGFloat {
        switch (self.dynamicType.type) {
        case (.Tweet):
            return 2
        case (.EnhancedBanner):
            return 6
        default:
            return 0
        }
    }
    
    var subHeadlineUpperLower: String? {
        switch (context, self.dynamicType.type) {
        case (.Article, .Streamer ):
            return subHeadline?.uppercaseString
        default:
            return subHeadline
        }
    }
    
    var subHeadlineAlignment: NSTextAlignment {
        switch self.dynamicType.type {
        case .EnhancedBanner, .UnsupportedContent, .Fallback :
            return NSTextAlignment.Center
        default:
            return NSTextAlignment.Left
        }
    }
    
    var attributedSubHeadline: NSAttributedString? {
        guard let subHeadline = self.subHeadlineUpperLower else { return NSAttributedString(string:"") }
        let attrs = StringAttributes(font: subHeadlineFont, foregroundColor: subHeadlineFontColor, lineSpacing: subHeadlineLinespacing, alignment: subHeadlineAlignment)
        return NSAttributedString(string:subHeadline, attributes:attrs.dictionary)
    }
}

extension ReadingTimeContainable {
    var shouldRenderReadingTime: Bool {
        guard let readingTime = self.readingTime else { return false }
        return !readingTime.isEmpty
    }
    
    var attributedReadingTime: NSAttributedString? {
        guard let readingTime = self.readingTime else { return NSAttributedString(string:"") }
        let attrs = StringAttributes(font: readingTimeFont, foregroundColor: readingTimeFontColor, lineSpacing: readingTimeLinespacing, alignment: readingTimeAlignment, shadow: readingTimeShadow)
        return NSAttributedString(string:readingTime, attributes:attrs.dictionary)
    }
    
    var readingTimeFontColor: UIColor {
        return Colors.titleOverImageColor
    }
    
    var readingTimeFont: UIFont {
        return Fonts.regularFont.fallbackWithSize(10)
    }
    
    var readingTimeLinespacing: CGFloat {
        return 0
    }
    
    var readingTimeAlignment: NSTextAlignment {
        return NSTextAlignment.Left
    }
    
    var readingTimeShadow: NSShadow? {
        if !shouldRenderShadow { return nil }
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = Colors.defaultShadowColor
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        return shadow
    }
    
    var shouldRenderShadow: Bool {
        return true
    }
}

extension PlainTextContainable {
    
    var plainTextFont: UIFont {
        switch (self.dynamicType.type, style) {
        case (.Fallback, _):
            return Fonts.lightFont.fallbackWithSize(15)
        case (_ , BlockStyle.InsetH1):
            return Fonts.alternativeMediumFont.fallbackWithSize(14)
        case (_, BlockStyle.InsetH2):
            return  Fonts.alternativeMediumFont.fallbackWithSize(16)
        case (_, BlockStyle.H2):
            return Fonts.mediumFont.fallbackWithSize(20)
        case (.ArticleRef, BlockStyle.Breaking):
            return Fonts.lightFont.fallbackWithSize(16)
        case (.ArticleRef, BlockStyle.ColumnHighlight),
             (.ArticleRef, BlockStyle.ColumnHighlightXL):
            return Fonts.textFont.fallbackWithSize(14)
        case (.Fallback, _):
            return Fonts.lightFont.fallbackWithSize(15)
        default:
            return Fonts.textFont.fallbackWithSize(14)
        }
        
    }
    
    var plainTextLinespacing: CGFloat {
        switch (self.dynamicType.type, style) {
        case (.Fallback, _): return 4
        default: return 6
        }
    }
    
    var plainTextBackgroundColor: UIColor {
        switch self.dynamicType.type {
        case .Fallback:
            return Colors.fallbackBackgroundColor
        default:
            return Colors.defaultBackgroundColor
        }
    }

    var plainTextColor: UIColor {
        switch style {
        case BlockStyle.InsetH1:
            return Colors.accentColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var attributedPlainText: NSAttributedString? {
        guard let plainText = self.plainText else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: plainTextFont, foregroundColor: plainTextColor, lineSpacing: plainTextLinespacing)
        let result = NSMutableAttributedString(string:plainText, attributes:attrs.dictionary)
        return result;
    }
    
    var shouldRenderPlainText: Bool {
        guard let _ = self.plainText else { return false }
        switch style {
        case BlockStyle.Alert:
            return true
        default:
            return false
        }
    }
}

extension RichTextContainable {
    var richTextAlignment: NSTextAlignment {
        switch self.dynamicType.type {
        case .EnhancedBanner :
            return .Center
        default:
            return .Left
        }
    }
    
    var linkColor: UIColor {
        switch self.dynamicType.type {
        case .EnhancedBanner :
            return Colors.callToAction
        default:
            return Colors.linkColor
        }
    }
    
    static func attributedString(fromRichText richText: String?, attributes: StringAttributes) -> NSAttributedString? {
        guard let richText = richText where !richText.isEmpty else { return nil }
        // somehow the guardian font renders a huge padding below each text node, this can be prevented by putting a bullshit tag in front
        let fixedRichText = "<voodoo>" + richText
        if let data = fixedRichText.dataUsingEncoding(NSUTF8StringEncoding) where data.length > 0 {
            return NSMutableAttributedString(HTMLData: data, options: attributes.dtOptions, linkColor: attributes.linkColor)
        } else {
            // fallback if string is somehow not encodable to nsdata
            let string = NSAttributedString(string: richText, attributes: attributes.dictionary)
            return string
        }
        
    }
    
    var attributedRichText: NSAttributedString? {
        let attributes = StringAttributes(font: richTextFont.fallbackWithSize(richTextFontSize), foregroundColor: richTextFontColor, backgroundColor: nil, lineSpacing: richTextLineSpacing, alignment: richTextAlignment, shadow: nil, linkColor: linkColor)
        return self.dynamicType.attributedString(fromRichText: self.richText, attributes: attributes)
    }
    
    var richTextFont: Font {
        switch (self.dynamicType.type, style) {
        case (.ArticleRef, BlockStyle.Breaking):
            return Fonts.lightFont
        case (.ArticleRef, BlockStyle.ColumnHighlight),
            (.ArticleRef, BlockStyle.ColumnHighlightXL):
            return Fonts.textFont
        case (.Text, BlockStyle.Intro):
            return Fonts.lightFont
        case (.EnhancedBanner, _):
            return Fonts.alternativeMediumFont
        case (.Text, BlockStyle.Byline), (_, BlockStyle.Inset), (.Image, _):
            return Fonts.alternativeTextFont
        case (.Tweet, _):
            return Fonts.tweetFont
        default:
            return Fonts.textFont
        }
    }
    
    var richTextFontColor: UIColor {
        switch (self.dynamicType.type, style) {
        case (.Text, BlockStyle.Byline):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.6)
        case (_, BlockStyle.Inset),(.Image, _):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.8)
        case (_, BlockStyle.InsetH1):
            return Colors.accentColor
        case (.Tweet, _):
            return Colors.tweetTextColor
        case (.EnhancedBanner, _):
            return Colors.enhancedBannerFontColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var richTextFontSize: CGFloat {
        switch style {
        case BlockStyle.Breaking:
            return 16
        case BlockStyle.Highlight,
             BlockStyle.HighlightXL,
            BlockStyle.Alert,
             BlockStyle.ColumnHighlight,
             BlockStyle.ColumnHighlightXL:
            return 14
        case BlockStyle.Intro:
            return 22
        case BlockStyle.Byline:
            return 14
        case BlockStyle.H2:
            return 20
        case BlockStyle.Column:
            return 26
        default:
            return 16
        }
    }
    
    var richTextLineSpacing: CGFloat {
        switch (self.dynamicType.type, style) {
        case (.ArticleRef, BlockStyle.Highlight),
             (.ArticleRef, BlockStyle.HighlightXL),
            (.ArticleRef, BlockStyle.Alert),
            (.ArticleRef, BlockStyle.Breaking),
            (.ArticleRef, BlockStyle.ColumnHighlight),
            (.ArticleRef, BlockStyle.ColumnHighlightXL):
            return 7
        case (.Text, BlockStyle.Intro):
            return 6
        case (.Text, BlockStyle.Byline):
            return 4
        case (.Text, BlockStyle.H2):
            return 4
        case (_, BlockStyle.Inset):
            return 3
        case (_, BlockStyle.InsetH1):
            return 4
        case (_, BlockStyle.InsetH2):
            return 6
        case (.Image, _):
            return 3
        case (.Tweet, _):
            return 3
        case (.EnhancedBanner, _):
            return 0
        default:
            return 11
        }
    }
    
    var tooMuchPaddingTop: CGFloat {
        // somehow ASDK does not render the text well: too much padding at the top
        return richTextLineSpacing / 2
    }
    
    var tooMuchClippingBottom: CGFloat {
        // somehow ASDK does not render the text well: too much clipping on the bottom
        return 1
    }
    
    var shouldRenderRichText: Bool {
        guard let richText = self.richText where !richText.isEmpty else { return false }
        switch style {
        case BlockStyle.ColumnHighlight, BlockStyle.HighlightImage:
            return false
        default:
            return true
        }
    }
}

extension ASImageNode {
    func maskWithRoundedCorners(corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 2, height: 2))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        self.layer.mask = maskLayer
    }
}

extension EnhancedBannerButtonData {
    
    var captionFont: UIFont {
        return Fonts.alternativeMediumFont.fallbackWithSize(16)
    }
    
    var captionColor: UIColor {
        return Colors.enhancedBannerFontColor
    }
    
    var buttonSize: CGSize {
        return CGSize(width: EnhancedBannerCellStyles.contentWidth, height: 48)
    }
    
    var attributedCaption: NSAttributedString {
        guard let label = self.caption else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: captionFont, foregroundColor: captionColor, alignment: NSTextAlignment.Center)
        return NSMutableAttributedString(string:label, attributes:attrs.dictionary)
    }
    
    func applyStyle(buttonNode: EnhancedBannerButtonNode) {
        buttonNode.layer.cornerRadius = 2
        switch self.style {
        case .Primary:
            buttonNode.layer.backgroundColor = color?.CGColor ?? Colors.callToAction.CGColor
        case .Normal:
            buttonNode.layer.backgroundColor = color?.CGColor ?? Colors.normalButton.CGColor
            buttonNode.layer.borderColor = Colors.normalButtonBorder.CGColor
            buttonNode.layer.borderWidth = 1
        }
    }
}

extension NSAttributedString {
    func boundingSizeForWidth(width: CGFloat) -> CGSize {
        let rect = self.boundingRectWithSize(CGSize(width: width, height: CGFloat.max), options:[NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context:nil)
        return rect.size
    }
}

extension UIButton {
    var titleLabelFont: UIFont {
        return Fonts.alternativeMediumFont.fallbackWithSize(13)
    }
}

extension UIButton {
    convenience init(paywallActionButtonTitle title: String, type buttonType: UIButtonType) {
        self.init(type: buttonType)
        setTitle(title, forState: .Normal)
        setTitleColor(Colors.paywallButtonTitleColor, forState: .Normal)
        titleLabel?.font = titleLabelFont
        var contentInsets = self.contentEdgeInsets
        contentInsets.top = 2
        contentInsets.left = 10
        contentInsets.right = contentInsets.left
        self.contentEdgeInsets = contentInsets
        backgroundColor = Colors.paywallButtonBackgroundColor
        self.layer.cornerRadius = 2
    }
}
