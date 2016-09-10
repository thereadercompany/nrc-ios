//
//  CornerInfo.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import Core

private extension DecorationType {
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

struct CornerInfo {
    let radius: CGFloat
    let position: UIRectCorner
    
    var radii: CGSize {
        return CGSize(width: radius, height: radius)
    }
    
    init(radius: CGFloat, position: UIRectCorner = .AllCorners) {
        self.radius = radius
        self.position = position
    }
    
    func corners(decoration type: DecorationType) -> UIRectCorner {
        return position.intersect(type.corners)
    }
}
