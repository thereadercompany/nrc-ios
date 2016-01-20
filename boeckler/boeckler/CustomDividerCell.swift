//
//  CustomDividerCell.swift
//  boeckler
//
//  Created by Emiel van der Veen on 19/01/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation

class CustomDividerCell : Cell {
    
    init(block: DividerBlock) {
        super.init(block: block)
    }
    
    var contentHeight: CGFloat {
        return DividerCellStyles.height
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let padding = block.decorationPadding
        let height = padding.top + contentHeight + padding.bottom
        return CGSize(width: constrainedSize.width, height: height)
    }
}