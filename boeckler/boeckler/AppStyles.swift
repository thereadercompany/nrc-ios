//
//  AppStyles.swift
//  ios-nrc-nl
//
//  Created by Emiel van der Veen on 19/08/15.
//

import Foundation
import AsyncDisplayKit
import DTCoreText

extension BlockStyle {
    static let Normal = BlockStyle(rawValue: "normal")
    static let Highlight = BlockStyle(rawValue: "highlight")
    static let HighlightXL = BlockStyle(rawValue: "highlight-xl")
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
    static let ThemeIceBlue = BlockStyle(rawValue: "theme-ice-blue")
    static let ThemeSand = BlockStyle(rawValue: "theme-sand")
}

struct Colors {
    static let placeholderColor = UIColor.lightGrayColor()
    static let accentColor = UIColor(hex: 0xD30910)
    static let iceBlue = UIColor(hex: 0xD3ECEE)
    static let sand = UIColor(hex: 0xEFEDE2)
    static let defaultBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let decorationBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let footerLineColor = accentColor
    static let linkColor = UIColor(hex: 0xD30910)
    static let cardBackgroundColor =  UIColor.whiteColor()
    static let articleBackgroundColor =  UIColor.whiteColor()
    static let timelineBackgroundColor =  UIColor.blackColor()
    static let timelineDividerBackgroundColor = Colors.accentColor
    static let timelineSpacingBackgroundColor = Colors.accentColor
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
    static let dividerBackgroundColor = accentColor
    static let navigationViewDarkBackgroundColor = accentColor
    static let navigationViewLightBackgroundColor = UIColor.whiteColor()
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
    static let errorBackgroundColor = UIColor(hex: 0xE6EAEE)
    static let errorMessageTextColor = UIColor(hex: 0x2A2D31)
    static let errorActionButtonTextColor = UIColor(hex: 0xD30910)
    static let refreshControlTintColor = UIColor(hex: 0xE6EAEE).colorWithAlphaComponent(0.6)
    static let loadingIndicatorColor = UIColor.whiteColor()
    static let imageBackgroundColor = UIColor(hex: 0xF6F6F6)
}

struct Fonts {
    static let textFont:Font = SabonNextCom.Regular
    static let regularFont:Font = UniversNextPro.Regular
    static let boldFont:Font = UniversNextPro.Bold
    static let mediumFont:Font = UniversNextPro.BoldCond
    static let largeFont:Font = UniversNextPro.BoldCond
    static let lightFont:Font = UniversNextPro.Regular
    static let alternativeTextFont: Font = SimpleHBS.Regular
    static let alternativeMediumFont: Font = SimpleHBS.Regular
    static let errorFont:Font = UniversNextPro.Bold
    static let introFont = UniversNextPro.Cond
    static let streamerFont = UniversNextPro.Cond
    static let imageCaptionFont = UniversNextPro.Cond
    static let defaultTaglineFont: Font = UniversNextPro.BoldCond
    static let defaultAuthorFont: Font = SimpleHBS.Regular
    static let tweetFont = HelveticaNeue.Light
    static let tweetHeadlineFont = HelveticaNeue.Medium
    
    static let fallbackUIFont = UIFont.systemFontOfSize(14)
    
    static func load() throws {
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
        case Cond
        case Bold        
        case BoldCond
    }
    
    enum SabonNextCom: String, Font {
        static let family = "SabonNextCom"
        case Regular
        case Italic
        case Bold
        case BoldItalic
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

struct GlobalStyles {
    static let defaultAspectRatio: CGFloat = 4/3
}

struct ContextStyles {
    static let endOfContentThreshold: CGFloat = 1.0
    static let hrefUnderlineStyle: NSUnderlineStyle = NSUnderlineStyle.StyleSingle
    static let pushAnimationDuration: NSTimeInterval = 0.45
    static let pushAnimationFadeInDuration: NSTimeInterval = 0.2
    static let popAnimationDuration: NSTimeInterval = 0.34
    static let popAnimationDurationXL: NSTimeInterval = 0.4
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
    static let navigationViewStyle = NavigationViewStyle.Dark(Colors.accentColor)
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
    static let pushToHideThreshold: CGFloat = 140
    static let backgroundColor = Colors.accentColor
    static func navigationViewNeedsLine(style: NavigationViewStyle) -> Bool {
        switch style {
        case .Light:
            return true
        default: return false
        }
    }
}

struct ArticleHeaderCellStyles {
    static let imageHeight: CGFloat = Window.vval([Screen.vXS: Screen.vXS*(9/12),Screen.vS:Screen.vS*(9/12),Screen.vM:Screen.vM*(9/12), Screen.vL:Screen.vL*9/12])
    static let headlineMarginTop: CGFloat = 32
}

struct FooterCellStyles {
    static let lineHeight: CGFloat = 4
}

struct DividerCellStyles {
    static let height: CGFloat = 8
    static let color: UIColor = Colors.accentColor
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

struct StreamerCellStyles {
    static let iconMarginTop: CGFloat = 25
    static let iconSize: CGFloat = 35
    static let iconMarginLeft: CGFloat = 19
    static let headlineMarginTop: CGFloat = 8
    static let headlineMarginBottom: CGFloat = 40
    static let subHeadlineMarginTop: CGFloat = 24
    static let subHeadlineMarginBottom: CGFloat = 36
    static let lineHeight: CGFloat = 1
}

struct TweetCellStyles {
    static let headlineLeftMargin: CGFloat = 8
    static let richTextLeftMargin: CGFloat = 20
    static let imageSize: CGFloat = 36
    static let twitterLogoSize = CGSize(width: 17, height: 14)
    static let topPadding: CGFloat = 20
    static let richTextTopMargin: CGFloat = 8
    static let bottomPadding: CGFloat = 26
    static let tweetDateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "d/MM/yy"
        return formatter
    }()
    
}
    
struct ImageCellStyles {
    static let textPaddingTop: CGFloat = 17
    static let textPaddingBottom: CGFloat = 19
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
    static let messageFont = Fonts.errorFont.optionalWithSize(14)
    static let buttonFont = Fonts.errorFont.optionalWithSize(14)
}

struct LoadingStyles {
    static let intensity: CGFloat = 0.15
    static let color: UIColor = UIColor.blackColor()
    static let refreshControlTintColor = UIColor.whiteColor()
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

    var imageDecorationPaddingBottom: CGFloat {
        switch self {
        case .Bottom, .Full: return 24
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

extension Block {
    
    var decorationPaddingSide: CGFloat {
        switch (self.context, self) {
        case (.Article, is TweetBlock):
            return 24
        default:
            return 0
        }
    }
    
    var decorationPaddingBottom: CGFloat {
        switch (self.context, self, style) {
        case (.Article, is TweetBlock, _):
            return self.decoration.tweetDecorationPaddingBottom
        case (.Article, is ImageBlock, _):
            return self.decoration.imageDecorationPaddingBottom
        case (.Article, is StreamerBlock, _):
            return 32
        default:
            return 0
        }
    }
    
    var decorationPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: decorationPaddingSide, bottom: decorationPaddingBottom, right: decorationPaddingSide)
    }
    
    var decorationColor: UIColor? {
        switch self {
        case is ImageBlock:
            return Colors.insetBackgroundColor
        case is DividerBlock:
            return Colors.accentColor
        default: ()
        }
        
        switch style {
        case BlockStyle.ThemeIceBlue where decoration != .None:
            return Colors.iceBlue
        case BlockStyle.ThemeSand where decoration != .None:
            return Colors.sand
        case BlockStyle.Inset,BlockStyle.InsetH1,BlockStyle.InsetH2 where decoration != .None:
            return Colors.insetBackgroundColor
        default: return nil
        }
    }
    
    func drawFullDecoration(view: UIView) {
        // currently not used
    }
        
    var contentPadding: UIEdgeInsets {
        let decorationPadding = self.decorationPadding

        var contentPadding: UIEdgeInsets
        switch (self.context, self, style) {
        case (.Timeline, is ArticleRefBlock, BlockStyle.Normal):
            contentPadding =  UIEdgeInsets(top: 19, left: 12, bottom: 0, right: 19)
        case (.Timeline, is ArticleRefBlock, BlockStyle.Highlight),
             (.Timeline, is ArticleRefBlock, BlockStyle.HighlightXL):
             contentPadding =  UIEdgeInsets(top: 19, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (_, is DividerBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        case (_, is TweetBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        case (_, is ImageBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 4, right: ArticleStyles.textInset)
        case (_, is UnsupportedContentBlock, _),(_, is FallbackBlock, _):
            contentPadding = UIEdgeInsets(top: 20, left: ArticleStyles.textInset, bottom: 20, right: ArticleStyles.textInset)
        case (.Timeline, _, _):
            contentPadding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (.Article, _, BlockStyle.Intro):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 31, right: ArticleStyles.textInset)
        case (.Article, is StreamerBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 0, right: ArticleStyles.textInset)
        case (.Article, is ArticleHeaderBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 28, right: ArticleStyles.textInset)
        case (.Article, is PlainTextBlock, BlockStyle.InsetH1):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 13, right: ArticleStyles.textInset)
        case (.Article, is PlainTextBlock, BlockStyle.H2):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 12, right: ArticleStyles.textInset)
        case (.Article, is TextBlock, BlockStyle.Byline):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 40, right: ArticleStyles.textInset)
        case (.Article, is FooterBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: FooterCellStyles.lineHeight, right: 0)
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
        switch (self, style ) {
        case (is StreamerBlock, _):
            return Colors.transparant
        case (is ArticleRefBlock, _):
            return Colors.defaultLineColor
        default:
            return Colors.defaultLineColor;
        }
    }
    
    var backgroundColor: UIColor {
        switch (context, self, style) {
        case (.Timeline, is DividerBlock, _):
            return Colors.timelineDividerBackgroundColor
        case (.Timeline, is SpacingBlock, _):
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
        switch (self, style) {
        case (is TextBlock, BlockStyle.Byline), (_, BlockStyle.Inset), (is ImageBlock, _):
            return Fonts.alternativeTextFont
        case (is TextBlock, BlockStyle.Intro):
            return Fonts.introFont
        case (_,BlockStyle.InsetH1), (_,BlockStyle.InsetH2):
            return Fonts.alternativeMediumFont
        case (_,BlockStyle.H2):
            return Fonts.mediumFont
        case (is TweetBlock, _):
            return Fonts.tweetFont
        default:
            return Fonts.textFont
        }
    }
    
    var fontColor: UIColor {
        switch (self, style) {
        case (is TextBlock, BlockStyle.Byline):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.6)
        case (_, BlockStyle.Inset),(is ImageBlock, _):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.8)
        case (_, BlockStyle.InsetH1):
            return Colors.accentColor
        case (is TweetBlock, _):
            return Colors.tweetTextColor
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
        default:
            return 16
        }
    }
    
    var lineSpacing: CGFloat {
        switch (self, style) {
        case (is TextBlock, BlockStyle.Intro):
            return 6
        case (is TextBlock, BlockStyle.Byline):
            return 4
        case (is TextBlock, BlockStyle.H2):
            return 4
        case (_, BlockStyle.Inset):
            return 3
        case (_, BlockStyle.InsetH1):
            return 4
        case (_, BlockStyle.InsetH2):
            return 6
        case (is ImageBlock, _):
            return 3
        case (is TweetBlock, _):
            return 3
        default:
            return 11
        }
    }
    
    var imageRatio: CGFloat {
        return 16/9
    }
    
    var paddingTop: CGFloat {
        switch (self, style) {
        case (is TextBlock, BlockStyle.H2):
            return 8+6
        case (is ArticleHeaderBlock, _):
            return 32
        default:
            return 0
        }
    }
    
    var paddingBottom: CGFloat {
        switch (self, style) {
        case ( _, BlockStyle.Intro):
            return 28
        case ( _, BlockStyle.Byline):
            return 32
        case ( _, BlockStyle.H2):
            return 8+6
        case ( _, BlockStyle.InsetH1):
            return 24
        case ( _, BlockStyle.InsetH2):
            return 8
        case ( is ArticleHeaderBlock, _):
            return 24+6
        case (is YoutubeBlock, _), (is VimeoBlock, _):
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
            return Fonts.textFont.fallbackWithSize(22)
        default:
            return Fonts.textFont.fallbackWithSize(16)
        }
    }
    
    var fontColor: UIColor {
        return Colors.defaultFontColor
    }
}

class Styler {
    var value: String?
    let style: String
    let block: Block
    
    static let NormalStyle = "normal"
    
    init(value:String?, style: String = NormalStyle, block: Block) {
        self.value = value
        self.style = style
        self.block = block
    }
}


class IssueLabelStyler: Styler {
    
    var issueLabelInset: CGPoint {
        return CGPoint(x: 19, y: 19)
    }
    
    var shouldRenderIssueLabel: Bool {
        guard let issueLabel = value else { return false }
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
    
    var attributedIssueLabel : NSAttributedString {
        guard let issueLabel = value else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: issueLabelFont, foregroundColor: issueLabelTextColor, lineSpacing: issueLabelTextLineSpacing, alignment: NSTextAlignment.Center)
        let result = NSMutableAttributedString(string:issueLabel, attributes:attrs.dictionary)
        return result;
    }}


class LabelStyler: Styler {
    
    static let linespacing: CGFloat = 3
    static let color = Colors.labelTextColor
    static let labelInset = CGPoint(x: 16, y: 12)
    static let labelTextInsets = UIEdgeInsets(top: 1, left: 6, bottom: 1, right: 6)
    
    static let CategoryStyle = "category"
    static let DateStyle = "date"
    
    var labelCornerRadius: CGFloat {
        return 0
    }
    
    var labelInset: CGPoint {
        return CGPoint(x: 19, y: 23)
    }
    
    var labelTextInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
    }
    
    var shouldRenderLabel: Bool {
        guard let label = value else { return false }
        return !label.isEmpty
    }
    
    var labelFont: UIFont {
        return Fonts.alternativeMediumFont.fallbackWithSize(11)
    }
    
    var labelTextColor: UIColor {
        switch block {
        case is DividerBlock:
            return Colors.dividerForegroundColor
        default:
            return Colors.labelTextColor
        }
    }
    
    var labelTextLineSpacing: CGFloat {
        return 0
    }
    
    var attributedLabel : NSAttributedString {
        guard let label = value else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: labelFont, foregroundColor: labelTextColor, lineSpacing: labelTextLineSpacing, alignment: NSTextAlignment.Center)
        let result = NSMutableAttributedString(string:label, attributes:attrs.dictionary)
        return result;
    }
    
    var labelBackgroundColor: UIColor? {
        return Colors.accentColor
    }
}


extension MediaBlock {
    var shouldRenderImage: Bool {
        guard !media.identifier.isEmpty else { return false }
        return true
    }
    
    func mediaHeightForWidth(width: CGFloat) -> CGFloat {
        return media.heightForWidth(width)
    }
    
    var mediaBackgroundColor: UIColor {
        switch self {
        case is ImageBlock:
            return Colors.imageBackgroundColor
        default:
            return backgroundColor
        }
    }
}

class HeadlineStyler : Styler {
        
    var headlineBackgroundColor: UIColor? {
        switch (block.context, block, block.style) {
//        case (.Timeline, _, _):
//            return Colors.titleOverImageBackgroundColor
        default:
            return nil
        }
    }
    
    var headlineFontColor: UIColor {
        switch (block.context, block, block.style) {
        case (.Timeline, _, BlockStyle.Highlight), (.Timeline, _, BlockStyle.HighlightXL):
            return Colors.titleOverImageColor
        case (.Article, is ArticleHeaderBlock, _):
            return Colors.accentColor
        case (.Article, is StreamerBlock, _):
            return Colors.accentColor
        case (_, is YoutubeBlock, _), (_, is VimeoBlock, _), (_, is UnsupportedContentBlock, _), (_, is FallbackBlock, _):
            return Colors.overlayFontColor
        case (_, is TweetBlock, _):
            return Colors.tweetTextColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var headlineFont: UIFont {
        switch (block.context, block, block.style) {
        case (.Timeline, is ArticleRefBlock, BlockStyle.Highlight):
            return Fonts.mediumFont.fallbackWithSize(24)
        case (.Timeline, is ArticleRefBlock, BlockStyle.HighlightXL):
            return Fonts.mediumFont.fallbackWithSize(34)
        case (.Article, is ArticleHeaderBlock,_):
            return Fonts.alternativeMediumFont.fallbackWithSize(34)
        case (.Article, is StreamerBlock, _):
            return Fonts.streamerFont.fallbackWithSize(32)
        case (_, is YoutubeBlock, _), (_, is VimeoBlock, _):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (.Article, is UnsupportedContentBlock, _),(.Article, is FallbackBlock, _):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (.Article, is TweetBlock, _):
            return Fonts.tweetHeadlineFont.fallbackWithSize(15)
        default:
            return Fonts.mediumFont.fallbackWithSize(22)
        }
    }
    
    var headlineLinespacing: CGFloat {
        switch (block.context, block, block.style) {
        case (.Timeline, _, BlockStyle.Highlight):
            return 4
        case (.Timeline, _, BlockStyle.HighlightXL):
            return 4
        case (.Timeline, _, BlockStyle.Normal):
            return 3
        case (.Article, is StreamerBlock, _ ):
            return 6
        case (_, is YoutubeBlock, _), (_, is VimeoBlock, _):
            return 3
        case (.Article, _,  _):
            return 7
        default:
            return 3
        }
    }
    
    var headlineAlignment: NSTextAlignment {
        switch block {
        case is UnsupportedContentBlock, is FallbackBlock :
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
        guard var headline = value else { return NSAttributedString() }
        
        if needsAllCaps {
            headline = headline.uppercaseString
        }
        
        let attrs = StringAttributes(font: headlineFont, foregroundColor: headlineFontColor, backgroundColor: headlineBackgroundColor, lineSpacing: headlineLinespacing, alignment: headlineAlignment, shadow: headlineShadow)
        return NSMutableAttributedString(string:headline, attributes:attrs.dictionary)
    }
    
    var shouldRenderShadow: Bool {
        switch block {
        case is ArticleHeaderBlock, is StreamerBlock:
            return false
        default: return true
        }
    }
    
    var needsAllCaps: Bool {
        switch block {
        case is ArticleHeaderBlock:
            return true
        default: return false
        }
    }
}

class SubHeadlineStyler : Styler {
    
    var shouldRenderSubHeadline: Bool {
        guard let subHeadline = value else { return false }
        return !subHeadline.isEmpty
    }

    var subHeadlineFontColor: UIColor {
        switch block {
        case is TweetBlock:
            return Colors.tweetSubHeadlineColor
        case is UnsupportedContentBlock, is FallbackBlock:
            return Colors.overlayFontColor
        case is StreamerBlock:
            return Colors.accentColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var subHeadlineFont: UIFont {
        switch block {
        case is TweetBlock:
            return Fonts.tweetFont.fallbackWithSize(15)
        case is UnsupportedContentBlock, is FallbackBlock:
            return Fonts.alternativeTextFont.fallbackWithSize(13)
        case is StreamerBlock:
            return Fonts.SabonNextCom.BoldItalic.fallbackWithSize(14)
        default:
            return Fonts.alternativeMediumFont.fallbackWithSize(14)
        }
    }
    
    var subHeadlineLinespacing: CGFloat {
        switch block {
        case is TweetBlock:
            return 2
        default:
            return 0
        }
    }
    
    var subHeadlineUpperLower: String? {
        return value
    }
    
    var subHeadlineAlignment: NSTextAlignment {
        switch block {
        case is UnsupportedContentBlock, is FallbackBlock :
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

class ReadingTimeStyler : Styler {
    var shouldRenderReadingTime: Bool {
        guard let readingTime = value else { return false }
        return !readingTime.isEmpty
    }
    
    var attributedReadingTime: NSAttributedString? {
        guard let readingTime = value else { return NSAttributedString(string:"") }
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

class PlainTextStyler : Styler {
    
    var plainTextFont: UIFont {
        switch (block, block.style) {
        case (is FallbackBlock, _):
            return Fonts.lightFont.fallbackWithSize(15)
        case (_ , BlockStyle.InsetH1):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (_, BlockStyle.InsetH2):
            return  Fonts.mediumFont.fallbackWithSize(16)
        case (_, BlockStyle.H2):
            return Fonts.mediumFont.fallbackWithSize(20)
        case (is FallbackBlock, _):
            return Fonts.lightFont.fallbackWithSize(15)
        default:
            return Fonts.textFont.fallbackWithSize(14)
        }
    }
    
    var plainTextLinespacing: CGFloat {
        switch (block, block.style) {
        case (is FallbackBlock, _): return 4
        default: return 4
        }
    }
    
    var plainTextBackgroundColor: UIColor {
        switch block {
        case is FallbackBlock:
            return Colors.fallbackBackgroundColor
        default:
            return Colors.defaultBackgroundColor
        }
    }

    var plainTextColor: UIColor {
        switch block.style {
        case BlockStyle.InsetH1:
            return Colors.accentColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var attributedPlainText: NSAttributedString? {
        guard let plainText = value else { return NSAttributedString(string: "") }
        let attrs = StringAttributes(font: plainTextFont, foregroundColor: plainTextColor, lineSpacing: plainTextLinespacing)
        let result = NSMutableAttributedString(string:plainText, attributes:attrs.dictionary)
        return result;
    }
    
    var shouldRenderPlainText: Bool {
        return false
    }
}

class RichTextStyler : Styler {
    var richTextAlignment: NSTextAlignment {
        return .Left
    }
    
    var linkColor: UIColor {
        return Colors.linkColor
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
        return self.dynamicType.attributedString(fromRichText: value, attributes: attributes)
    }
    
    var richTextFont: Font {
        switch (block.self, block.style) {
        case (is TextBlock, BlockStyle.Intro):
            return Fonts.introFont
        case (is TextBlock, BlockStyle.Byline):
            return Fonts.alternativeTextFont
        case  (_, BlockStyle.Inset):
            return Fonts.textFont
        case (is ImageBlock, _):
            return Fonts.imageCaptionFont
        case (is TweetBlock, _):
            return Fonts.tweetFont
        default:
            return Fonts.textFont
        }
    }
    
    var richTextFontColor: UIColor {
        switch (block, block.style) {
        case (is TextBlock, BlockStyle.Byline):
            return Colors.defaultFontColor.colorWithAlphaComponent(0.6)
        case (_, BlockStyle.InsetH1):
            return Colors.accentColor
        case (is TweetBlock, _):
            return Colors.tweetTextColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var richTextFontSize: CGFloat {
        
        if case is ImageBlock = block {
            return 16
        }
        
        switch block.style {
        case BlockStyle.Highlight,
             BlockStyle.HighlightXL:
            return 14
        case BlockStyle.Intro:
            return 22
        case BlockStyle.Byline:
            return 14
        case BlockStyle.H2:
            return 20
        default:
            return 17
        }
    }
    
    var richTextLineSpacing: CGFloat {
        switch (block, block.style) {
        case (is ArticleRefBlock, BlockStyle.Highlight),
             (is ArticleRefBlock, BlockStyle.HighlightXL):
            return 7
        case (is TextBlock, BlockStyle.Intro):
            return 6
        case (is TextBlock, BlockStyle.Byline):
            return 4
        case (is TextBlock, BlockStyle.H2):
            return 4
        case (_, BlockStyle.Inset):
            return 8
        case (_, BlockStyle.InsetH1):
            return 4
        case (_, BlockStyle.InsetH2):
            return 6
        case (is ImageBlock, _):
            return 3
        case (is TweetBlock, _):
            return 3
        default:
            return 7
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
        guard let richText = value where !richText.isEmpty else { return false }
        return true
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

extension Article {
    var backgroundColor: UIColor  {
        return UIColor.whiteColor()
    }
}

