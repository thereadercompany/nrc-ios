//
//  ASTextNode.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASTextNode {
    // optional initializer that returns nil if text is nil. this makes it more convenient to initialize an optional textNode in containing nodes
    convenience init?(text: NSAttributedString?) {
        guard let text = text else { return nil }
        self.init()
        self.attributedText = text
    }
}

extension ASNetworkImageNode {
    // optional initializer that returns nil if url is nil. this makes it more convenient to initialize an optional imageNode in containing nodes
    convenience init?(url: NSURL?) {
        guard let url = url else { return nil }
        self.init()
        self.URL = url
    }
}
