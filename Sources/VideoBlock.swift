//
//  VideoBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 15/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core

class VideoBlock: Block {
    let media: Media
    let URL: NSURL
    let title: String?
    let autoplay: Bool
    let autorepeat: Bool

    required init?(decoder: JSONDecoder, context: String) {
        media = decoder.value(["attributes", "media"], nullValue: .null)
        URL = decoder.value(["attributes", "url"], nullValue: NSURL())
        title = decoder.value(["attributes", "title"])
        autoplay = decoder.value(["attributes", "autoplay"], false)
        autorepeat = decoder.value(["attributes", "autorepeat"], false)
        
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
