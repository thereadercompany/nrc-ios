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
    let URL: NSURL
    let autoplay: Bool
    let autorepeat: Bool
    let controls: Bool
    let aspectRatio: CGFloat

    required init?(decoder: JSONDecoder, context: String) {
        URL = decoder.value(["attributes", "url"], nullValue: NSURL())
        autoplay = decoder.value(["attributes", "autoplay"], false)
        autorepeat = decoder.value(["attributes", "autorepeat"], false)
        controls = decoder.value(["attributes", "controls"], false)
        aspectRatio = decoder.value(["attributes", "aspect-ratio"], Media.defaultAspectRatio)
        
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
