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
    let thickness: CGFloat
    let length: CGFloat?
    
    init(color: UIColor, thickness: CGFloat, length: CGFloat? = nil) {
        self.color = color
        self.thickness = thickness
        self.length = length
    }
}
