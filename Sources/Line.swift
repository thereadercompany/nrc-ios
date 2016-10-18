//
//  Line.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation

/**
 Model Object for drawing a line
 */
struct Line {
    let color: UIColor
    let size: CGSize
    
    init(color: UIColor, size: CGSize) {
        self.color = color
        self.size = size
    }
}
