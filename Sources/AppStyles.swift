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
import NRCFonts

//MARK: - BlockStyle

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
    
    case Unknown = "unknown"
    
    init(style: String) {
        self = BlockStyle(rawValue: style) ?? .Unknown
    }
}

extension Renderable {
    var blockStyle: BlockStyle {
        return BlockStyle(style: style)
    }
}

//MARK: - BlockContextType

enum BlockContextType: String {
    case Timeline = "timelines"
    case Article = "articles"
    case Paywall = "paywalls"
    case Onboarding = "onboardings"
    
    case Unknown = "unknown"
    
    init(context: String) {
        self = BlockContextType(rawValue: context) ?? .Unknown
    }
}

extension Renderable {
    var blockContext: BlockContextType {
        return BlockContextType(context: context)
    }
}

//MARK - Colors

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
    
    //TODO: unused
    static let tweetSubheadlineColor = UIColor(hex: 0xB1B4B5)
    
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

    //MARK - NRC
    static let nrcRed = UIColor(hex: 0xD20810)
    static let nrcRedLight = UIColor(hex: 0xFBE9E9)
    static let nrcTextColor = UIColor(hex: 0x191919)
    static let nrcLinkColor = UIColor(hex: 0x0b4f89)
    static let nrcAnthracite = UIColor(hex: 0x1A1A1A)
    static let nrcAnthraciteLightness70 = UIColor(hex: 0x676767)
    static let nrcAnthraciteLightness80 = UIColor(hex: 0x4d4d4d)
}

struct Fonts {
    static let textFont: NRCFonts.Font = GuardianText.Regular
    static let boldTextFont: NRCFonts.Font = GuardianText.Bold
    static let italicTextFont: NRCFonts.Font = GuardianText.RegularItalic
    static let boldItalicTextFont: NRCFonts.Font = GuardianText.BoldItalic
    static let regularFont: NRCFonts.Font = GuardianHeadline.Regular
    static let mediumFont: NRCFonts.Font = GuardianHeadline.Medium
    static let largeFont: NRCFonts.Font = GuardianHeadline.Semibold
    static let lightFont: NRCFonts.Font = GuardianHeadline.Light
    static let italicFont: NRCFonts.Font = GuardianHeadline.LightItalic
    static let alternativeTextFont: NRCFonts.Font = Etica.Regular
    static let alternativeMediumFont: NRCFonts.Font = Etica.SemiBold
    static let alternativeLightFont: NRCFonts.Font = Etica.Light
    static let alternativeItalicFont: NRCFonts.Font = Etica.Italic
    
    static let errorFont: NRCFonts.Font = Etica.SemiBold
    
    static let tweetFont = HelveticaNeue.Light
    static let tweetTitleFont = HelveticaNeue.Medium
    static let labelFont: NRCFonts.Font = Etica.Book
    
    static let defaultTaglineFont = mediumFont
    static let defaultKeywordFont = mediumFont
    static let defaultAuthorFont = alternativeMediumFont
    static let bylineFont = alternativeMediumFont
    
    static let fallbackUIFont = UIFont.systemFontOfSize(14)

    static func load() throws {
        try NRCFonts.Loader.loadFontsIfNeeded([
            GuardianText.Regular, GuardianText.Bold, GuardianText.RegularItalic, GuardianText.BoldItalic,
            GuardianHeadline.Regular,GuardianHeadline.Medium,GuardianHeadline.Semibold,GuardianHeadline.Light,GuardianHeadline.LightItalic,
            Etica.Regular,Etica.SemiBold,Etica.Italic]
        )
    }
    
    enum HelveticaNeue: String, NRCFonts.Font {
        static let family = "Helvetica"
        static let style = "Neue"
        case Light
        case Medium
    }
}

extension NRCFonts.Font {
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

struct ContextStyles {
    static let endOfContentThreshold: CGFloat = 1.0
    static let hrefUnderlineStyle: NSUnderlineStyle = NSUnderlineStyle.StyleSingle
    static let pushAnimationDuration: NSTimeInterval = 0.54
    static let pushAnimationFadeInDuration: NSTimeInterval = 0.2
    static let popAnimationDuration: NSTimeInterval = 0.34
    static let popAnimationDurationXL: NSTimeInterval = 0.4
}

struct TimelineStyles {
    static let navBarAutoHideEnabled = false
    static let enablePullToRefresh = true
    static let topInset: CGFloat = 85
    static let defaultMargin: CGFloat = 0
    static let internalMargin: CGFloat = 16
    static let contentInset: CGFloat = 15
    static let backgroundColorBoot = Colors.timelineBackgroundColor
    static let backgroundColor = Colors.timelineBackgroundColor
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar
    static let lineInset: CGFloat = 16
    static let lineHeight: CGFloat = 1
    static let initiallyHideNavigationView = false
    static let navigationViewStyle = NavigationViewStyle.Dark(Colors.navigationViewLightBackgroundColor)
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
    static func imageForTimelineDecoration(decoration: DecorationType, imagePosition: DecorationType? = .None) -> UIImage? {
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
    
    static let numberFontSize = 22
    static let numberFontColor = Colors.nrcRed

    //    static func navigationViewNeedsLine(style: NavigationViewStyle) -> Bool {
    //        switch style {
    //        case .Light:
    //            return true
    //        default: return false
    //        }
    //    }
}

enum QuoteStyles {
    static let quotationMarkFont = Fonts.textFont
    static let quotationMarkFontSize = 33
    static let lineColor = Colors.quoteLineColor
    static let lineSize = CGSize(width: 48, height: 1)
    static let spacingBeforeText: CGFloat = 18
    static let spacingAfterText: CGFloat = 14
    static let spacingAfterAuthor: CGFloat = 18
}

func backgroundImageProvider(imagePolicy: ImagePolicy, block: Block) -> [NSURL] {
    switch block {
    case let mediaBlock as MediaBlock:
        if mediaBlock.media.identifier.isEmpty { return [] }
        return [imagePolicy.URL(block: mediaBlock, media: mediaBlock.media)]
    default:
        return []
    }
}

class ArticleRefCellStyles: Core.ArticleRefCellStyles {
    var titleFont = Fonts.mediumFont.fallbackWithSize(19)
    var titleFontColor = Colors.defaultFontColor
    
    var abstractFont = Fonts.lightFont.fallbackWithSize(20)
    var abstractFontColor = Colors.defaultFontColor
    
    var labelFont = Fonts.labelFont.fallbackWithSize(10)
    var labelTextColor = Colors.labelTextColor
    var labelBackgroundColor = Colors.labelBackgroundColor
    
    var lineColor = Colors.defaultLineColor
    var lineHeight: CGFloat = 0.5
}

struct DividerStyles {
    static let height: CGFloat = 8
    static let color: UIColor = Colors.accentColor
}

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

enum ErrorStyles {
    static let font: NRCFonts.Font = Etica.SemiBold
    static let messageFont = font.fallbackWithSize(14)
    static let buttonFont = font.fallbackWithSize(14)
}

struct LoadingStyles {
    static let intensity: CGFloat = 0.15
    static let color: UIColor = UIColor.blackColor()
    static let refreshControlTintColor = Colors.refreshControlTintColor
}

extension DecorationType {
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


extension Core.ImageBlock {
    var textPaddingTop: CGFloat {
        return Screen.value(17,14)
    }
    
    var textPaddingBottom: CGFloat {
        switch decoration {
        case .None, .Full:
            return Screen.value(18,24)
        default:
            return Screen.value(23,40)
        }
    }
}

extension NSAttributedString {
    convenience init(string: String, attributes: StringAttributes, style: BlockStyle) {
        // wrap richtext in a style tag so styles can be applied accordingly in the dtcore text style sheet
        let fixedString = "<\(style.rawValue)>" + string + "</\(style.rawValue)>"
        if let data = fixedString.dataUsingEncoding(NSUTF8StringEncoding) where data.length > 0 {
            let attributedString = NSMutableAttributedString(HTMLData: data, options: attributes.dtOptions)
            
            guard attributedString.length > 0 else {
                self.init(attributedString: attributedString)
                return
            }
            
            // add hyphenationfactor, linespacing, headindent and firstline headindent
            let range = NSRange(location: 0, length: attributedString.length)
            if let paragraphstyle = attributedString.attribute(NSParagraphStyleAttributeName, atIndex: 0, longestEffectiveRange: nil, inRange: range) as? NSMutableParagraphStyle {
                paragraphstyle.hyphenationFactor = attributes.hyphenationFactor
                paragraphstyle.lineSpacing = attributes.lineSpacing ?? 0
                paragraphstyle.headIndent = attributes.headIndent ?? 0
                paragraphstyle.firstLineHeadIndent = attributes.firstLineHeadIndent ?? 0
                attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphstyle, range: range)
            }
            
            self.init(attributedString: attributedString)
        } else {
            // fallback if string is somehow not encodable to nsdata
            self.init(string: string, attributes: attributes)
        }
    }
}

