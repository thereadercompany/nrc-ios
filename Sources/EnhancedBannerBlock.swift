//
//  EnhancedBannerBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 27/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core
import Argo
import Curry

class EnhancedBannerBlock: Block {
    let media: Media?
    let title: String?
    let subtitle: String?
    let text: String?
    let buttons: [EnhancedBannerButtonData]?
    
    required init?(decoder: JSONDecoder, context: String) {
        media = decoder.value(["attributes", "media"])
        title = decoder.value(["attributes", "title"])
        subtitle = decoder.value(["attributes", "subtitle"])
        text = decoder.value(["attributes", "text"])
        buttons = decoder.array(["attributes", "buttons"])
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}

enum EnhancedBannerButtonStyle: String, Decodable {
    case Normal = "normal"
    case Primary = "primary"
    
    init?(string: String) {
        guard let style = EnhancedBannerButtonStyle(rawValue: string) else { return nil }
        self = style
    }
    
    static func decode(json: JSON) -> Decoded<EnhancedBannerButtonStyle> {
        switch json {
        case .String(let string):
            if let style = (EnhancedBannerButtonStyle(string: string) ) {
                return pure(style)
            }
            return .Failure(.TypeMismatch(expected: "EnhancedBannerButtonStyle", actual: json.description))
        default:
            return .Failure(.TypeMismatch(expected: "String", actual: json.description))
        }
    }
}

struct EnhancedBannerButtonData: Trackable, Decodable {
    var style: EnhancedBannerButtonStyle
    var URL: NSURL
    let title: String
    //MARK: Trackable
    let trackingData: TrackingData?
    
    static var curriedInit: EnhancedBannerButtonStyle -> NSURL -> String -> TrackingData? ->  EnhancedBannerButtonData {
        return curry(self.init)
    }
    
    static func decode(json: JSON) -> Decoded<EnhancedBannerButtonData> {
        return curriedInit
            <^> json <| "style" <%|> pure(.Normal)
            <*> json <| "url"
            <*> json <| "title"
            <*> json <|? "tracking"
    }
}
