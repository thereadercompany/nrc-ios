//
//  LabelNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

public struct LabelModel {
    let text: String
    let font: UIFont
    let textColor: UIColor
    let textInsets: UIEdgeInsets
    let backgroundColor: UIColor
    
    public init(text: String,
                font: UIFont = Fonts.labelFont.fallbackWithSize(10),
                textColor: UIColor = Colors.labelTextColor,
                textInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10),
                backgroundColor: UIColor  = Colors.labelBackgroundColor) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textInsets = textInsets
        self.backgroundColor = backgroundColor
    }
    var attributes: StringAttributes {
        return StringAttributes(font: font, foregroundColor: textColor, lineSpacing: 0)
    }
    var attributedString: NSAttributedString {
        return NSAttributedString(string: text, attributes: attributes.dictionary)
    }
}

public class LabelNode : ASDisplayNode {
    let textNode = ASTextNode()
    let model: LabelModel
    public init?(model: LabelModel?) {
        guard let model = model else { return nil }
        
        self.model = model
        super.init()
        self.addSubnode(self.textNode)
        textNode.userInteractionEnabled = true
        textNode.linkAttributeNames = [ linkAttributeName ];
    }
    
    public var text: NSAttributedString? {
        didSet {
            self.textNode.attributedString = text
        }
    }
    
    override public func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let textSize = self.textNode.calculateSizeThatFits(constrainedSize)
        let width = textSize.width + (model.textInsets.left + model.textInsets.right)
        let height = textSize.height + (model.textInsets.top + model.textInsets.bottom)
        return CGSize(width: width, height: height)
    }
    
    override public func layout() {
        super.layout()
        let width = self.frame.width - (model.textInsets.left + model.textInsets.right)
        let height = self.frame.height - (model.textInsets.top + model.textInsets.bottom)
        let origin = CGPoint(x: (frame.width-width)/2, y: model.textInsets.top)
        self.textNode.frame = CGRect(origin: origin, size: CGSize(width: width, height: height))
    }
}
    