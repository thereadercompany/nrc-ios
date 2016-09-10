//
//  ContentNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

class CellContent {
    let backgroundColor: UIColor
    let padding: UIEdgeInsets
    
    init(backgroundColor: UIColor, padding: UIEdgeInsets = UIEdgeInsets()) {
        self.backgroundColor = backgroundColor
        self.padding = padding
    }
}

class ContentNode<C: CellContent>: ASDisplayNode {
    let content: C
    
    required init(content: C) {
        self.content = content
        super.init()
        
        backgroundColor = content.backgroundColor
    }
}