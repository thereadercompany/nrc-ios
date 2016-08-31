//
//  BylineBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 31/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core
import Argo

enum InlineIcon: String, Decodable {
    case Clock = "clock"
    case Pen = "pen"
    
    var image: UIImage {
        return UIImage(named: "icon-\(rawValue)")!
    }
}

class BylineBlock: PlainTextBlock {
    let icon: InlineIcon
    
    required init?(decoder: JSONDecoder, context: BlockContextType) {
        icon = decoder.value(["attributes", "icon-name"], nullValue: .Pen)
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
