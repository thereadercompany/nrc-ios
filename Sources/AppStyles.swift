////
////  AppStyles.swift
////  ios-nrc-nl
////
////  Created by Emiel van der Veen on 19/08/15.
////
//
//import Foundation
//import AsyncDisplayKit
import DTCoreText
import Core

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
    static let Image = BlockStyle(rawValue: "image")
    static let Inset = BlockStyle(rawValue: "inset")
    static let InsetH1 = BlockStyle(rawValue: "inset-h1")
    static let InsetH2 = BlockStyle(rawValue: "inset-h2")
    static let ArticleFooter = BlockStyle(rawValue: "article-footer")
}

public struct Colors {
    static let placeholderColor = UIColor.lightGrayColor()
    static let accentColor = UIColor(hex: 0xD30910)
    static let accentColorDarker = Colors.accentColor.darker()
    static let iceBlue = UIColor(hex: 0xD3ECEE)
    static let sand = UIColor(hex: 0xEFEDE2)
    static let defaultBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let decorationBorderColor = UIColor.blackColor().colorWithAlphaComponent(0.05)
    static let footerLineColor = accentColor
    static let linkColor = UIColor(hex: 0xD30910)
    static let cardBackgroundColor =  UIColor.whiteColor()
    static let statusViewBackgroundColor = UIColor.whiteColor()
    static let statusViewTextColor = Colors.accentColor
    static let articleBackgroundColor =  UIColor.whiteColor()
    static let timelineBackgroundColor =  UIColor(hex: 0x2A2D31)
    static let timelineDividerBackgroundColor = Colors.accentColor
    static let timelineSpacingBackgroundColor = Colors.accentColor
    static let imageBackgroundColor = UIColor(hex: 0xF9FAFB)
    static let insetBackgroundColor = Colors.sand
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
    static let fallbackBackgroundColor = UIColor.whiteColor()
    static let overlayFontColor = UIColor.whiteColor()
    static let labelTextColor = UIColor.whiteColor()
    static let taglineFontColor = UIColor(hex: 0xD30910)
    static let errorBackgroundColor = UIColor(hex: 0xE6EAEE)
    static let errorMessageTextColor = UIColor(hex: 0x2A2D31)
    static let errorActionButtonTextColor = UIColor(hex: 0xD30910)
    static let refreshControlTintColor = UIColor(hex: 0xE6EAEE).colorWithAlphaComponent(0.6)
    static let loadingIndicatorColor = UIColor.whiteColor()
}

struct Fonts {
    static let textFont:Font = SabonNextCom.Regular
    static let regularFont:Font = UniversNextPro.Regular
    static let boldFont:Font = UniversNextPro.Bold
    static let mediumFont:Font = UniversNextPro.BoldCond
    static let largeFont:Font = UniversNextPro.BoldCond
    static let lightFont:Font = UniversNextPro.Regular
    static let bylineFont: Font = UniversNextPro.Regular
    static let bylineMediumFont: Font = UniversNextPro.BoldCond
    static let alternativeTextFont: Font = SimpleHBS.Regular
    static let alternativeMediumFont: Font = SimpleHBS.Regular
    static let errorFont:Font = UniversNextPro.Bold
    static let introFont = UniversNextPro.Cond
    static let streamerFont = UniversNextPro.Cond
    static let mediaCaptionFont = UniversNextPro.Cond
    static let defaultTaglineFont: Font = UniversNextPro.BoldCond
    static let defaultAuthorFont: Font = SimpleHBS.Regular
    static let tweetFont = HelveticaNeue.Light
    static let tweetHeadlineFont = HelveticaNeue.Medium
    
    static let fallbackUIFont = UIFont.systemFontOfSize(14)
    static let statusFont = UIFont.boldSystemFontOfSize(11.5)
    
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
//
//struct GlobalStyles {
//    static let defaultAspectRatio: CGFloat = 4/3
//}
//
struct ContextStyles {
    static let endOfContentThreshold: CGFloat = 1.0
    static let hrefUnderlineStyle: NSUnderlineStyle = NSUnderlineStyle.StyleSingle
    static let pushAnimationDuration: NSTimeInterval = 0.45
    static let pushAnimationFadeInDuration: NSTimeInterval = 0.2
    static let popAnimationDuration: NSTimeInterval = 0.34
    static let popAnimationDurationXL: NSTimeInterval = 0.4
}
//
//struct StatusManagerStyles {
//    static let statusBarStyle = UIStatusBarStyle.LightContent
//}
//
struct TimelineStyles {
    static let navBarAutoHideEnabled = false
    static let enablePullToRefresh = true
    static let topInset: CGFloat = 85
    static let defaultMargin: CGFloat = 0
    static let internalMargin: CGFloat = 16
    static let contentInset: CGFloat = Screen.isTablet ?30:16
    static let backgroundColorBoot = Colors.timelineBackgroundColor
    static let backgroundColor = Colors.timelineBackgroundColor
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar
    static let lineInset: CGFloat = 16
    static let lineHeight: CGFloat = 1
    static let initiallyHideNavigationView = false
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
    static let navBarAutoHideEnabled = true
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar    
    static var textInset: CGFloat { return Screen.value(24,80,208) }
    static var specialInset: CGFloat { return Screen.value(0,40,168) }
    static let pushToHideThreshold: CGFloat = 120
    static let backgroundColor = Colors.accentColor
//    static func navigationViewNeedsLine(style: NavigationViewStyle) -> Bool {
//        switch style {
//        case .Light:
//            return true
//        default: return false
//        }
//    }
}






struct CellStyleFactory {
    static let highlight = stylesBuilder(HighlightCellStyles()) {(s, block: ArticleRefBlock) in
        s.centerHeadline = false
        s.maximumLineCount = 3
        s.headlineMarginTop = 18
        s.richTextMarginTop = 6
        s.roundedImageCorners = []

        s.defaultBackgroundColor = Colors.defaultBackgroundColor

        s.issueLabelBackgroundColor = IssueLabelStyles.backgroundColor

        switch block.style {
        case BlockStyle.HighlightXL:
            s.gradientPositions = [.Top(0.2, 0.6), .Bottom(0.7, 0.8)]
            s.popDuration = ContextStyles.popAnimationDurationXL
        default:
            s.gradientPositions = [.Bottom(0.5, 0.9)]
            s.popDuration = ContextStyles.popAnimationDuration
        }
        s.initialSpringVelocity = 0.95

        s.attributedIssueLabel = IssueLabelStyler(value: block.issueLabel, style: block.style.rawValue, block: block).attributedIssueLabel
        s.attributedHeadline = HeadlineStyler(value: block.headline, style: block.style.rawValue, block: block).attributedHeadline
        let labelStyler = LabelStyler(value: block.label, style: block.style.rawValue, block: block)
        s.attributedLabel = labelStyler.attributedLabel
        let readingTimeStyler = ReadingTimeStyler(value: block.readingTime, style: block.style.rawValue, block: block)
        s.attributedReadingTime = readingTimeStyler.attributedReadingTime


        s.labelTextInsets = LabelStyles.labelTextInsets
        s.labelBackgroundColor = Colors.accentColor
        s.labelInsetBottom = labelStyler.labelInsetBottom

        s.readingTimeInsetLeft = readingTimeStyler.insetLeft

        s.contentPadding = block.contentPadding

        s.sizeThatFits = {(constrainedWidth) in
            switch block.style {
            case BlockStyle.HighlightXL:
                let height = Screen.value(constrainedWidth, 536, 640)
                return CGSize(width: constrainedWidth, height: height)
            case BlockStyle.Highlight:
                let height = round(Screen.value(constrainedWidth*0.7,338,430))
                return CGSize(width: constrainedWidth, height: height)
            default:
                let width = Screen.value(constrainedWidth,constrainedWidth/2)
                let height = round(Screen.value(width*0.7,302,348))
                return CGSize(width: width, height: height)
            }
        }
        
        s.pushAnimationDuration = ContextStyles.pushAnimationDuration

        s.headerImageHeight = Window.vval([Screen.vXS: Screen.vXS*(9/12),Screen.vS:Screen.vS*(9/12),Screen.vM:Screen.vM*(9/12), Screen.vL:Screen.vL*9/12])

        s.articleBackgroundColor = {(article: Article?) in Colors.articleBackgroundColor }

        s.placeholderColor = Colors.placeholderColor
        s.decorationColor = block.decorationColor
        s.backgroundColor = block.backgroundColor
    }

    static let articleHeader = stylesBuilder(ArticleHeaderCellStyles()) { (s: ArticleHeaderCellStyles, block: ArticleHeaderBlock) in
        s.imageHeight = Window.vval([Screen.vXS: Screen.vXS*(9/12),Screen.vS:Screen.vS*(9/12),Screen.vM:Screen.vM*(9/12), Screen.vL:Screen.vL*9/12])
        s.headlineMarginTop = Screen.value(32,52)
        s.minImageHeight = TimelineStyles.navigationBarHeight
        s.contentPadding = block.contentPadding
        s.attributedHeadline = HeadlineStyler(value: block.headline, style: block.style.rawValue, block: block).attributedHeadline

        s.placeholderColor = Colors.placeholderColor
        s.supportedMediaFormats = block.supportedMediaFormats


        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.mediaHeightForWidth = {width in block.media.heightForWidth(width)}
    }

    static let text = stylesBuilder(TextCellStyles()) { (s: TextCellStyles, block: TextBlock) in
        s.contentPadding = block.contentPadding
        s.paddingTop = block.paddingTop
        let styler = RichTextStyler(value: block.richText, style: block.style.rawValue, block: block)
        s.tooMuchPaddingTop = styler.tooMuchPaddingTop
        s.tooMuchClippingBottom = styler.tooMuchClippingBottom
        s.attributedRichText = styler.attributedRichText

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor
    }

    static let plainText = stylesBuilder(PlainTextCellStyles()) { (s: PlainTextCellStyles, block: PlainTextBlock) in
        s.attributedPlainText = PlainTextStyler(value: block.plainText, style: block.style.rawValue, block: block).attributedPlainText
        s.contentPadding = block.contentPadding

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor
    }

    static let streamer = stylesBuilder(CustomStreamerCellStyles()) { (s: CustomStreamerCellStyles, block: StreamerBlock) in
        s.attributedHeadline = HeadlineStyler(value: block.text, style: block.style.rawValue, block: block).attributedHeadline
        let subHeadlineStyler = SubHeadlineStyler(value: block.author, style: block.style.rawValue, block: block)
        s.attributedSubHeadline = subHeadlineStyler.attributedSubHeadline
        s.shouldRenderSubHeadline = subHeadlineStyler.shouldRenderSubHeadline

        s.contentPadding = block.contentPadding


        s.iconMarginTop = StreamerCellStyles.iconMarginTop
        s.iconSize = StreamerCellStyles.iconSize
        s.iconMarginLeft = StreamerCellStyles.iconMarginLeft
        s.headlineMarginTop = StreamerCellStyles.headlineMarginTop
        s.headlineMarginBottom = StreamerCellStyles.headlineMarginBottom
        s.subHeadlineMarginTop = StreamerCellStyles.subHeadlineMarginTop
        s.subHeadlineMarginBottom = StreamerCellStyles.subHeadlineMarginBottom

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor
    }

    static let image = stylesBuilder(ImageCellStyles()) { (s: ImageCellStyles, block: ImageBlock) in
        s.imageRatio = 16/9
        s.contentPadding = block.contentPadding
        s.textPaddingTop = block.textPaddingTop
        s.textPaddingBottom = block.textPaddingBottom

        s.attributedCaption = RichTextStyler(value: block.caption, block: block).attributedRichText

        s.decorationBorderColor = block.decorationColor

        s.popDuration = ContextStyles.popAnimationDuration
        s.pushAnimationDuration = ContextStyles.pushAnimationDuration

        s.supportedMediaFormats = block.supportedMediaFormats
        s.placeholderColor = Colors.placeholderColor

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.mediaHeightForWidth = {width in block.media.heightForWidth(width)}
    }

    static let spacing = stylesBuilder(SpacingCellStyles()) { (s: SpacingCellStyles, block: SpacingBlock) in
        s.topShadowAlpha = 0.4
        s.bottomShadowAlpha = 0.4

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor
    }

    static let footer = stylesBuilder(FooterCellStyles()) { (s: FooterCellStyles, block: SpacingBlock) in
        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.footerLineColor = Colors.footerLineColor
        s.contentPadding = block.contentPadding
        s.lineHeight = 4
    }

    static let fallback = stylesBuilder(FallbackContentCellStyles()) { (s: FallbackContentCellStyles, block: FallbackBlock) in
        s.attributedHeadline = HeadlineStyler(value: block.headline, style: block.style.rawValue, block: block).attributedHeadline
        s.attributedSubHeadline = SubHeadlineStyler(value: block.subHeadline, style: block.style.rawValue, block: block).attributedSubHeadline

        s.contentPadding = block.contentPadding
        
        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.mediaHeightForWidth = {width in block.media.heightForWidth(width)}
    }

    static let twitter = stylesBuilder(TweetCellStyles()) { (s: TweetCellStyles, block: TweetBlock) in
    }

    static let youtube = stylesBuilder(YoutubeCellStyles()) { (s: YoutubeCellStyles, block: YoutubeBlock) in
        s.paddingBottom = block.paddingBottom
        s.playImageLeftMargin = VideoStyles.playImageLeftMargin
        s.playImageBottomMargin = VideoStyles.playImageLeftMargin

        s.mediaPaddingSide = block.mediaPaddingSide
        s.imageRatio = block.imageRatio
        s.contentPadding = block.contentPadding
        s.textPaddingTop = block.textPaddingTop
        s.textPaddingBottom = block.textPaddingBottom
        s.attributedCaption = RichTextStyler(value: block.caption, block: block).attributedRichText

        //        public var popDuration: NSTimeInterval = 10
        //        public var popAnimationDuration: NSTimeInterval = 10
        //        public var pushAnimationDuration: NSTimeInterval = 10
        s.supportedMediaFormats = block.supportedMediaFormats
        s.placeholderColor = Colors.placeholderColor

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.mediaHeightForWidth = {width in block.media.heightForWidth(width)}
    }

    static let vimeo = stylesBuilder(VimeoCellStyles()) { (s: VimeoCellStyles, block: VimeoBlock) in
        s.paddingBottom = block.paddingBottom
        s.playImageLeftMargin = VideoStyles.playImageLeftMargin
        s.playImageBottomMargin = VideoStyles.playImageLeftMargin

        s.mediaPaddingSide = block.mediaPaddingSide
        s.imageRatio = block.imageRatio
        s.contentPadding = block.contentPadding
        s.textPaddingTop = block.textPaddingTop
        s.textPaddingBottom = block.textPaddingBottom
        s.attributedCaption = RichTextStyler(value: block.caption, block: block).attributedRichText

//        public var popDuration: NSTimeInterval = 10
//        public var popAnimationDuration: NSTimeInterval = 10
//        public var pushAnimationDuration: NSTimeInterval = 10
        s.supportedMediaFormats = block.supportedMediaFormats
        s.placeholderColor = Colors.placeholderColor

        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor

        s.mediaHeightForWidth = {width in block.media.heightForWidth(width)}
    }

    static let divider = stylesBuilder(DividerCellStyles()) { (s: DividerCellStyles, block: DividerBlock) in
        s.backgroundColor = block.backgroundColor
        s.decorationColor = block.decorationColor
        s.defaultContextBackgroundColor = Colors.articleBackgroundColor
    }

}



//
//struct FooterCellStyles {
//    static let lineHeight: CGFloat = 4
//}
//
struct DividerStyles {
    static let height: CGFloat = 8
    static let color: UIColor = Colors.accentColor
}


//
//struct ArticleRefCellStyles {
//    static let maximumLineCount: UInt = 3
//    static let headlineMarginTop: CGFloat = 18
//    static let richTextMarginTop: CGFloat = 6
//    static let richTextInset: CGFloat = 12
//    static let breakingHeadlineMarginTop: CGFloat = 24
//    static let breakingRichTextMarginTop: CGFloat = 16
//    static let height: CGFloat = Window.hval([Screen.hS:306,Screen.hM:342,Screen.hL:367])
//    static func roundedImageCorners() -> UIRectCorner {
//        return []
//    }
//    
//    static func gradientPositions(style: BlockStyle) -> [GradientPosition] {
//        switch style {
//        case BlockStyle.HighlightXL:
//            return [.Top(0.2, 0.6), .Bottom(0.7, 0.8)]
//        default:
//            return [.Bottom(0.5, 0.9)]
//        }
//    }
//}
//

struct StreamerCellStyles {
    static let iconMarginTop: CGFloat = 25
    static let iconSize: CGFloat = 35
    static let iconMarginLeft: CGFloat = Screen.value(19, 24)
    static let headlineMarginTop: CGFloat = Screen.value(8, 12)
    static let headlineMarginBottom: CGFloat = 24
    static let subHeadlineMarginTop: CGFloat = 24
    static let subHeadlineMarginBottom: CGFloat = 0
    static let lineHeight: CGFloat = 1
}
//
//struct TweetCellStyles {
//    static let headlineLeftMargin: CGFloat = 8
//    static let richTextLeftMargin: CGFloat = 20
//    static let imageSize: CGFloat = 36
//    static let twitterLogoSize = CGSize(width: 17, height: 14)
//    static let topPadding: CGFloat = 20
//    static let richTextTopMargin: CGFloat = 8
//    static let bottomPadding: CGFloat = 26
//    static let tweetDateFormatter: NSDateFormatter = {
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "d/MM/yy"
//        return formatter
//    }()
//    
//}
//    
struct VideoStyles {
    static let captionPaddingBottom: CGFloat = 12
    static let captionPaddingLeftRight: CGFloat = 24
    static let gradientAspectRatio: CGFloat = 3.9
    static let playImageLeftMargin: CGFloat =  ArticleStyles.specialInset+Screen.value(12,19)
    static let playImageBottomMargin : CGFloat = Screen.value(12,19)
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
    static let font = Fonts.lightFont.fallbackWithSize(13)
}

struct ErrorStyles {
    static let messageFont = Fonts.errorFont.optionalWithSize(14)!
    static let buttonFont = Fonts.errorFont.optionalWithSize(14)!
}

struct LoadingStyles {
    static let intensity: CGFloat = 0.15
    static let color: UIColor = UIColor.blackColor()
    static let refreshControlTintColor = UIColor.whiteColor()
}
//
//extension NavigationViewStyle {
//    var backgroundColor: UIColor {
//        switch self {
//        case .Transparent:
//            return Colors.navigationViewTransparentBackgroundColor
//        case .Dark:
//            return Colors.navigationViewDarkBackgroundColor
//        case .Light:
//            return Colors.navigationViewLightBackgroundColor
//        }
//    }
//    
//    var titleColor: UIColor {
//        switch self {
//        case .Transparent, .Dark:
//            return Colors.navigationViewDarkTitleColor
//        case .Light:
//            return Colors.navigationViewLightTitleColor
//        }
//    }
//    
//    var subtitleColor: UIColor {
//        switch self {
//        case .Transparent, .Dark:
//            return Colors.navigationViewDarkSubtitleColor
//        case .Light:
//            return Colors.navigationViewLightSubtitleColor
//        }
//    }
//    
//    var titleFont: UIFont {
//        return Fonts.alternativeMediumFont.fallbackWithSize(16)
//    }
//    
//    var subtitleFont: UIFont? {
//        return Fonts.alternativeTextFont.fallbackWithSize(11)
//    }
//    
//    var autoHideDelay: NSTimeInterval? {
//        return 2
//    }
//}
//
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
//
//extension UIView {
//    func drawFullCardDecoration() {
//        alpha = 1
//        layer.cornerRadius = 2
//        layer.shadowColor = Colors.cardShadowColor.CGColor
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 3
//    }
//}
//
extension Block {
    
    var decorationPaddingSide: CGFloat {
        switch (self.context, self, self.style) {
        case (CoreBlockContextType.Article, is TweetBlock, _):
            return 24
        case (CoreBlockContextType.Article, is ImageBlock, BlockStyle.Inset):
            return 0
        case (CoreBlockContextType.Article, is ImageBlock, _), (CoreBlockContextType.Article, is StreamerBlock, _):
            return ArticleStyles.specialInset
        default:
            return 0
        }
    }
    
    var decorationPaddingBottom: CGFloat {
        switch (self.context, self, style) {
        case (CoreBlockContextType.Article, is TweetBlock, _):
            return self.decoration.tweetDecorationPaddingBottom
        case (CoreBlockContextType.Article, is StreamerBlock, _):
            return 32
        default:
            return 0
        }
    }

    var decorationPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: decorationPaddingSide, bottom: decorationPaddingBottom, right: decorationPaddingSide)
    }
    
    var mediaPaddingSide: CGFloat {
        switch(self.context) {
            case CoreBlockContextType.Article:
                return ArticleStyles.specialInset
            default:
                return 0
        }
    }
    
    var decorationColor: UIColor? {
        switch self {
        case is ImageBlock:
            return Colors.imageBackgroundColor
        case is DividerBlock:
            return Colors.accentColor
        case is StreamerBlock:
            return Colors.sand
        default: ()
        }
        
        switch style {
        case BlockStyle.Inset,BlockStyle.InsetH1,BlockStyle.InsetH2 where decoration != .None:
            return Colors.insetBackgroundColor
        case BlockStyle.Image where decoration != .None:
            return Colors.imageBackgroundColor
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
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, _):
             contentPadding =  UIEdgeInsets(top: 19, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (_, is DividerBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        case (_, is TweetBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: 20, bottom: 24, right: 20)
        case (_, is ImageBlock, BlockStyle.Inset):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 0, right: ArticleStyles.textInset)            
        case (_, is ImageBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset-ArticleStyles.specialInset, bottom: 0, right: ArticleStyles.textInset-ArticleStyles.specialInset)
        case (_, is UnsupportedContentBlock, _),(_, is FallbackBlock, _):
            contentPadding = UIEdgeInsets(top: 20, left: ArticleStyles.textInset, bottom: 20, right: ArticleStyles.textInset)
        case (CustomBlockContextType.Timeline, _, _):
            contentPadding = UIEdgeInsets(top: 0, left: TimelineStyles.contentInset, bottom: 0, right: TimelineStyles.contentInset)
        case (CoreBlockContextType.Article, _, BlockStyle.Intro):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 31, right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is StreamerBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset-ArticleStyles.specialInset, bottom: 0, right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is ArticleHeaderBlock, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: Screen.value(28,36), right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is PlainTextBlock, BlockStyle.InsetH1):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: 13, right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is PlainTextBlock, BlockStyle.H1):
            contentPadding = UIEdgeInsets(top: 8, left: ArticleStyles.textInset, bottom: Screen.value(16,20), right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is PlainTextBlock, BlockStyle.H2):
            contentPadding = UIEdgeInsets(top: 8, left: ArticleStyles.textInset, bottom: Screen.value(12,12), right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is TextBlock, BlockStyle.Byline):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: Screen.value(40,48), right: ArticleStyles.textInset)
        case (CoreBlockContextType.Article, is SpacingBlock, BlockStyle.ArticleFooter):
            contentPadding = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        case (CoreBlockContextType.Article, _, _):
            contentPadding = UIEdgeInsets(top: 0, left: ArticleStyles.textInset, bottom: Screen.value(24, 30), right: ArticleStyles.textInset)
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
        case (CustomBlockContextType.Timeline, is DividerBlock, _):
            return Colors.timelineDividerBackgroundColor
        case (CustomBlockContextType.Timeline, is SpacingBlock, _):
            return Colors.timelineSpacingBackgroundColor
        case (CustomBlockContextType.Timeline, _, _):
            return Colors.cardBackgroundColor
        case (CoreBlockContextType.Article, _, _):
            return Colors.articleBackgroundColor
        default:
            return Colors.defaultBackgroundColor
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
            return Screen.value(12,24)
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

extension ImageBlock {
    var textPaddingTop: CGFloat {
        return Screen.value(17,14)
    }
    
    var textPaddingBottom: CGFloat {
        switch decoration {
            case BlockDecoration.None, BlockDecoration.Full:
                return Screen.value(18,24)
            default:
                return Screen.value(23,40)
        }
        

    }
}
//
//extension ArticleRefBlock {
//    func sizeThatFits(constrainedWidth: CGFloat) -> CGSize {
//        switch style {
//        case BlockStyle.HighlightXL:
//            let height = Screen.value(constrainedWidth, 536, 640)
//            return CGSize(width: constrainedWidth, height: height)
//        case BlockStyle.Highlight:
//            let height = round(Screen.value(constrainedWidth*0.7,338,430))
//            return CGSize(width: constrainedWidth, height: height)
//        default:
//            let width = Screen.value(constrainedWidth,constrainedWidth/2)
//            let height = round(Screen.value(width*0.7,302,348))
//            return CGSize(width: width, height: height)
//        }
//    }
//}
//
//extension MarkupTag {
//    var font: UIFont {
//    switch self {
//        case .Tagline:
//            return Fonts.textFont.fallbackWithSize(22)
//        default:
//            return Fonts.textFont.fallbackWithSize(16)
//        }
//    }
//    
//    var fontColor: UIColor {
//        return Colors.defaultFontColor
//    }
//}
//
//


public class RichTextStyler: Styler {
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
            return Fonts.bylineFont
        case (is MediaBlock, _):
            return Fonts.mediaCaptionFont
        case (is TweetBlock, _):
            return Fonts.tweetFont
        case  (_, BlockStyle.Inset):
            return Fonts.textFont
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

        if case is MediaBlock = block {
            return Screen.value(16,20)
        }

        if case is ArticleRefBlock = block {
            return 14
        }

        switch block.style {
        case BlockStyle.Intro:
            return Screen.value(22,26)
        case BlockStyle.Byline:
            return Screen.value(14,18)
        default:
            return Screen.value(17,22)
        }
    }

    var richTextLineSpacing: CGFloat {
        switch (block, block.style) {
        case (is ArticleRefBlock, _):
            return 7
        case (is TextBlock, BlockStyle.Intro):
            return Screen.value(6,9)
        case (is TextBlock, BlockStyle.Byline):
            return 4
        case (_, BlockStyle.Inset):
            return 8
        case (is MediaBlock, _):
            return Screen.value(3,6)
        case (is TweetBlock, _):
            return 3
        default:
            return Screen.value(7,10)
        }
    }

    var tooMuchPaddingTop: CGFloat {
        //TODO: somehow ASDK does not render the text well: too much padding at the top
        return richTextLineSpacing / 2
    }

    var tooMuchClippingBottom: CGFloat {
        //TODO: somehow ASDK does not render the text well: too much clipping on the bottom
        return 1
    }

    var shouldRenderRichText: Bool {
        guard let richText = value where !richText.isEmpty else { return false }
        return true
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
        let result = NSMutableAttributedString(string:issueLabel.uppercaseString, attributes:attrs.dictionary)
        return result;
    }}


class LabelStyler: Styler {
    
    static let linespacing: CGFloat = 3
    static let color = Colors.labelTextColor
    static let labelTextInsets = UIEdgeInsets(top: 1, left: 6, bottom: 1, right: 6)
    
    static let CategoryStyle = "category"
    static let DateStyle = "date"
    
    var labelCornerRadius: CGFloat {
        return 0
    }
    
    var labelInsetBottom: CGFloat {
        switch (block, block.style) {
        case (is ArticleRefBlock, BlockStyle.Normal),(is ArticleRefBlock, BlockStyle.Highlight):
            return Screen.value(23,28)
        case (is ArticleRefBlock, BlockStyle.HighlightXL):
            return Screen.value(23,49)
        default:
            return 0
        }
    }
    
    var labelTextInsets: UIEdgeInsets {
        let topBottom : CGFloat = Screen.value(2,4)
        let leftRight : CGFloat = Screen.value(10,12)
        return UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
    }
    
    var shouldRenderLabel: Bool {
        guard let label = value else { return false }
        return !label.isEmpty
    }
    
    var labelFont: UIFont {
        return Fonts.alternativeMediumFont.fallbackWithSize(Screen.value(11,13))
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
        guard let label = value?.uppercaseString else { return NSAttributedString(string: "") }
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
    
//    var mediaBackgroundColor: UIColor {
//        switch self {
//        case is ImageBlock:
//            return Colors.imageBackgroundColor
//        default:
//            return backgroundColor
//        }
//    }

    var supportedMediaFormats: [MediaFormat] {
        switch (self, self.style) {
        case (is ArticleRefBlock, BlockStyle.Normal):
            return Screen.value([MediaFormat.Medium,MediaFormat.Small],[MediaFormat.Medium,MediaFormat.Small])
        default:
            return Screen.value([MediaFormat.Medium,MediaFormat.Small],[MediaFormat.Large,MediaFormat.Medium,MediaFormat.Small])
        }
    }
}
//
class HeadlineStyler : Styler {
    
    var centerHeadline: Bool {
        
        if Screen.isPhone { return false }
        
        switch block.style {
        case BlockStyle.HighlightXL:
            return true
        default:
            return false
        }
    }
    
    var headlineBackgroundColor: UIColor? {
        return nil
    }
    
    var headlineFontColor: UIColor {
        switch (block.context, block, block.style) {
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, _):
            return Colors.titleOverImageColor
        case (CoreBlockContextType.Article, is ArticleHeaderBlock, _):
            return Colors.accentColor
        case (CoreBlockContextType.Article, is StreamerBlock, _):
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
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.Normal):
            return Fonts.mediumFont.fallbackWithSize(24)
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.Highlight):
            return Fonts.mediumFont.fallbackWithSize(Screen.value(24, 36))
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.HighlightXL):
            return Fonts.mediumFont.fallbackWithSize(Screen.value(36,53))
        case (CoreBlockContextType.Article, is ArticleHeaderBlock,_):
            return Fonts.alternativeMediumFont.fallbackWithSize(Screen.value(34,38))
        case (CoreBlockContextType.Article, is StreamerBlock, _):
            return Fonts.streamerFont.fallbackWithSize(32)
        case (_, is MediaBlock, _):
            return Fonts.lightFont.fallbackWithSize(Screen.value(16,18))
        case (CoreBlockContextType.Article, is UnsupportedContentBlock, _),(CoreBlockContextType.Article, is FallbackBlock, _):
            return Fonts.mediumFont.fallbackWithSize(18)
        case (CoreBlockContextType.Article, is TweetBlock, _):
            return Fonts.tweetHeadlineFont.fallbackWithSize(15)
        default:
            return Fonts.mediumFont.fallbackWithSize(22)
        }
    }
    
    var headlineLinespacing: CGFloat {
        switch (block.context, block, block.style) {
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.Highlight),(CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.Normal):
            return Screen.value(3,4)
        case (CustomBlockContextType.Timeline, is ArticleRefBlock, BlockStyle.HighlightXL):
            return Screen.value(3,4)
        case (CoreBlockContextType.Article, is StreamerBlock, _ ):
            return 6
        case (_, is ArticleHeaderBlock, _):
            return Screen.value(3, 6)
        case (_, is MediaBlock, _):
            return Screen.value(3, 60)
        case (CoreBlockContextType.Article, _,  _):
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
    
    var insetBottom: CGFloat {
        switch (block, block.style) {
        case (is ArticleRefBlock, BlockStyle.Highlight), (is ArticleRefBlock, BlockStyle.Normal):
            return Screen.value(4,8)
        case (is ArticleRefBlock, BlockStyle.HighlightXL):
            return Screen.value(8,10)
        default:
            return 0
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
        return NSAttributedString(string:readingTime.uppercaseString, attributes:attrs.dictionary)
    }
    
    var readingTimeFontColor: UIColor {
        return Colors.titleOverImageColor
    }
    
    var readingTimeFont: UIFont {
        return Fonts.regularFont.fallbackWithSize(Screen.value(10,13))
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
    
    var insetLeft: CGFloat {
        return Screen.value(10,12)
    }
}

class PlainTextStyler : Styler {
    
    var plainTextFont: UIFont {
        switch (block, block.style) {
        case (is FallbackBlock, _):
            return Fonts.lightFont.fallbackWithSize(15)
        case (_ , BlockStyle.InsetH1):
            return Fonts.mediumFont.fallbackWithSize(Screen.value(20,24))
        case (_, BlockStyle.InsetH2):
            return  Fonts.mediumFont.fallbackWithSize(16)
        case (_, BlockStyle.H1):
            return Fonts.alternativeMediumFont.fallbackWithSize(Screen.value(20, 24))
        case (_, BlockStyle.H2):
            return Fonts.mediumFont.fallbackWithSize(Screen.value(20, 24))
        case (is FallbackBlock, _):
            return Fonts.lightFont.fallbackWithSize(15)
        default:
            return Fonts.textFont.fallbackWithSize(14)
        }
    }
    
    var plainTextLinespacing: CGFloat {
        return Screen.value(4,6)
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
        case BlockStyle.InsetH1, BlockStyle.H1:
            return Colors.accentColor
        default:
            return Colors.defaultFontColor
        }
    }
    
    var attributedPlainText: NSAttributedString? {
        guard var plainText = value else { return NSAttributedString(string: "") }
        
        if needsAllCaps {
            plainText = plainText.uppercaseString
        }

        let attrs = StringAttributes(font: plainTextFont, foregroundColor: plainTextColor, lineSpacing: plainTextLinespacing)
        let result = NSMutableAttributedString(string:plainText, attributes:attrs.dictionary)
        return result;
    }
    
    var needsAllCaps: Bool {
        switch (block.context, block.style)  {
        case (CoreBlockContextType.Article, BlockStyle.H1):
            return true
        default: return false
        }
    }
    
    var shouldRenderPlainText: Bool {
        return false
    }
}

//extension ASImageNode {
//    func maskWithRoundedCorners(corners: UIRectCorner) {
//        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 2, height: 2))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = self.bounds
//        maskLayer.path = maskPath.CGPath
//        self.layer.mask = maskLayer
//    }
//}
//
//extension UIButton {
//    var titleLabelFont: UIFont {
//        return Fonts.alternativeMediumFont.fallbackWithSize(13)
//    }
//}
//
//extension UIButton {
//    convenience init(paywallActionButtonTitle title: String, type buttonType: UIButtonType) {
//        self.init(type: buttonType)
//        setTitle(title, forState: .Normal)
//        setTitleColor(Colors.paywallButtonTitleColor, forState: .Normal)
//        titleLabel?.font = titleLabelFont
//        var contentInsets = self.contentEdgeInsets
//        contentInsets.top = 2
//        contentInsets.left = 10
//        contentInsets.right = contentInsets.left
//        self.contentEdgeInsets = contentInsets
//        backgroundColor = Colors.paywallButtonBackgroundColor
//        self.layer.cornerRadius = 2
//    }
//}
//
//extension Article {
//    var backgroundColor: UIColor  {
//        return UIColor.whiteColor()
//    }
//}
//
