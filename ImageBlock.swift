//
//  ImageBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 14/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core

class ImageBlock: Core.ImageBlock {
    let credit: String?
    
    required init?(decoder: JSONDecoder, context: String) {
        credit = decoder.value(["attributes", "credit"])
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
