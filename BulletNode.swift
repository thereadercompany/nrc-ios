//
//  BulletNode.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

struct Bullet {
    let color: UIColor
    let radius: CGFloat
    let pulsate: Bool
    
    var diameter: CGFloat {
        return 2 * radius
    }
    
    init(color: UIColor, radius: CGFloat, pulsate: Bool = false) {
        self.color = color
        self.radius = radius
        self.pulsate = pulsate
    }
}

class BulletNode: ASDisplayNode {
    let bullet: Bullet
    
    init(bullet: Bullet) {
        self.bullet = bullet
        
        super.init()
        
        backgroundColor = bullet.color
        cornerRadius = bullet.radius
        let diameter = bullet.diameter
        preferredFrameSize = CGSize(width: diameter, height: diameter)
    }
    
    // optional initializer that returns nil if bullet is nil. this makes it more convenient to initialize an optional bulletNode in containing nodes
    convenience init?(bullet: Bullet?) {
        guard let bullet = bullet else { return nil }
        self.init(bullet: bullet)
    }
    
    override func visibleStateDidChange(isVisible: Bool) {
        super.visibleStateDidChange(isVisible)
        guard bullet.pulsate else { return }
        pulsate(isVisible)
    }

    private func pulsate(pulsate: Bool) {
        if pulsate {
            let growFactor: CGFloat = 1.4
            UIView.animateWithDuration(0.75, delay: 0, options: [.CurveEaseInOut, .Autoreverse, .Repeat], animations: {
                self.transform = CATransform3DMakeScale(growFactor, growFactor, 1)
                }, completion: nil)
        }
        else {
            layer.removeAllAnimations()
            transform = CATransform3DIdentity
        }
    }

}
