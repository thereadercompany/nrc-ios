//
//  CustomDividerCell.swift
//  boeckler
//
//  Created by Emiel van der Veen on 19/01/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Core
import UIKit

class CustomDividerCell : Cell {
    
    init(block: DividerBlock, styles: CellStyles) {
        super.init(block: block, styles: styles)
    }
    
    var contentHeight: CGFloat {
        return 8
    }
    
    override func calculateSizeThatFits(constrainedSize: CGSize) -> CGSize {
        let padding = block.decorationPadding
        let height = padding.top + contentHeight + padding.bottom
        return CGSize(width: constrainedSize.width, height: height)
    }
}