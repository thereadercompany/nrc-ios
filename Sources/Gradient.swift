//
//  Gradient.swift
//  NRC
//
//  Created by Taco Vollmer on 05/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit

/**
 Model object for drawing a linear gradient
 */
struct LinearGradient {
    let colors: [UIColor]
    let start: CGPoint
    let end: CGPoint
    
    init(colors: [UIColor], start: CGPoint = CGPoint(x: 0.5, y: 0), end: CGPoint = CGPoint(x: 0.5, y: 1)) {
        self.colors = colors
        self.start = start
        self.end = end
    }
    
    /** returns: `colors` as CGColor */
    var CGColors: [CGColor] {
        return colors.map { $0.CGColor }
    }
}