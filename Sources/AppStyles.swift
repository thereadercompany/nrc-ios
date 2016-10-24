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

struct ContextStyles {
    static let pushAnimationFadeInDuration: NSTimeInterval = 0.2
}

struct TimelineStyles {
    static let navBarAutoHideEnabled = false
    static let contentInset: CGFloat = 15
    static let navigationViewStyle = NavigationViewStyle.Dark(Colors.navigationViewLightBackgroundColor)
}

struct ArticleStyles {
    static let topInset: CGFloat = 0
    static let navBarAutoHideEnabled = true
    static let navigationBarHeight: CGFloat = 85 //65 + 20 statusbar
    static let pushToHideThreshold: CGFloat = 120
    static let backgroundColor = Colors.accentColor
    
    static let numberFontSize = 22
    static let numberFontColor = Colors.nrcRed
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

extension NSAttributedString {
    convenience init(string: String, attributes: StringAttributes, style: BlockStyle) {
        // wrap richtext in a style tag so styles can be applied accordingly in the dtcore text style sheet
        let fixedString = "<\(style.rawValue)>" + string + "</\(style.rawValue)>"
        if let data = fixedString.dataUsingEncoding(NSUTF8StringEncoding) where data.length > 0 {
            let attributedString = NSMutableAttributedString(HTMLData: data, options: attributes.dtOptions)
    static var textInset: CGFloat = 20
            
            guard attributedString.length > 0 else {
                self.init(attributedString: attributedString)
                return
            }
            
            // add hyphenationfactor, linespacing, headindent and firstline headindent
            let range = NSRange(location: 0, length: attributedString.length)
            if let paragraphstyle = attributedString.attribute(NSParagraphStyleAttributeName, atIndex: 0, longestEffectiveRange: nil, inRange: range) as? NSMutableParagraphStyle {
                // We disable this for now, waiting for https://github.com/facebook/AsyncDisplayKit/issues/1284 to be fixed
//                paragraphstyle.hyphenationFactor = attributes.hyphenationFactor
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

