//
//  ArticleRefBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 30/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core
import Argo

enum Theme: String {
    case Default = "default"
    case Urgent = "urgent"
    case Live = "live"
    case Highlight = "highlight"
}

extension Theme: Decodable {
    static func decode(json: JSON) -> Decoded<Theme> {
        guard case .String(let name) = json else {
            return .typeMismatch("String", actual: json)
        }
        guard let theme = Theme(rawValue: name) else {
            return .typeMismatch("Theme name",actual: name)
        }
        return pure(theme)
    }
}

class ArticleRefBlock: Core.ArticleRefBlock {
    let url: NSURL?
    let theme: Theme
    required internal init?(decoder: JSONDecoder, context: BlockContextType) {
        url = decoder.value(["attributes", "url"])
        theme = decoder.value(["attributes", "theme"], .Default)
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
