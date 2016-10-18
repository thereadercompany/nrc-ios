//
//  Fonts.swift
//  NRC
//
//  Created by Taco Vollmer on 18/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import NRCFonts

//MARK: - Fonts
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
