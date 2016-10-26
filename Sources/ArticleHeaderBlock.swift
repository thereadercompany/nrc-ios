//
//  ArticleHeaderBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 24/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core

class ArticleHeaderBlock: Core.Block {
    let media: Media?
    let title: String
    
    required init?(decoder: JSONDecoder, context: String) {
        media = decoder.value(["attributes", "media"])
        title = decoder.value(["attributes", "title"], nullValue: "")
        super.init(decoder: decoder, context: context)
        
        if decoder.error != nil { return nil }
    }
}

extension ArticleHeaderBlock: CustomDebugStringConvertible {
    var debugDescription: String {
        return "id:\(identifier),type:\(self.dynamicType) - \(title)"
    }
}