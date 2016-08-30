//
//  LoginButton.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 04/09/15.
//  Copyright © 2015 The Reader Company. All rights reserved.
//

import Foundation

class LoginButton : UIButton {
    convenience init(title: String) {
        self.init(frame: CGRectZero)
        setTitle(title, forState: .Normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(Colors.paywallButtonTitleColor, forState: .Normal)
        titleLabel?.font = Fonts.alternativeTextFont.fallbackWithSize(12)
        var contentInsets = self.contentEdgeInsets
        contentInsets.top = 4
        contentInsets.bottom = 2
        contentInsets.left = 8
        contentInsets.right = contentInsets.left
        self.contentEdgeInsets = contentInsets
        setBackgroundImage(UIImage(named: "paywall-action-button-background")!, forState: .Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func backgroundRectForBounds(bounds: CGRect) -> CGRect {
        let labelHeight = titleLabel?.frame.height ?? 0
        let insetsHeight = contentEdgeInsets.top + contentEdgeInsets.bottom
        let height = labelHeight + insetsHeight
        let y = round((bounds.height - height) / 2)
        return CGRect(x: bounds.origin.x, y: y, width: bounds.width, height: height)
    }
}