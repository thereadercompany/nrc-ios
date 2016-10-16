//
//  CornerInfo.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import Core

/**
 Model object for drawing rounded corners
 */
struct CornerInfo {
    let radius: CGFloat
    let corners: UIRectCorner
    
    var radii: CGSize {
        return CGSize(width: radius, height: radius)
    }
    
    init(radius: CGFloat, corners: UIRectCorner = .AllCorners) {
        self.radius = radius
        self.corners = corners
    }
    
    /** returns: the `UIRectCorner` set that intersects with `corners` */
    func corners(decoration type: DecorationType) -> UIRectCorner {
        return corners.intersect(type.corners)
    }
}

private extension DecorationType {
    /** Converts a DecorationType to a UIRectcorner OptionSet */
    var corners: UIRectCorner {
        switch self {
        case .Full:
            return [.TopLeft, .TopRight, .BottomLeft, .BottomRight]
        case .Top:
            return [.TopLeft, .TopRight]
        case .Bottom:
            return [.BottomLeft, .BottomRight]
        default:
            return []
        }
    }
}
