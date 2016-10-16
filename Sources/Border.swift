//
//  Border.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit

/**
 Model object for drawing a border
 */
public struct Border {
    public let color: UIColor
    public let width: CGFloat
    
    public init(color: UIColor, width: CGFloat = 1) {
        self.color = color
        self.width = width
    }
}
