//
//  SectionRefBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core

class SectionRefBlock: Block {
    let label: String
    
    required init?(decoder: JSONDecoder, context: BlockContextType) {
        label = decoder.value(["attributes", "label"], "")
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}
