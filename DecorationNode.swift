import UIKit
import AsyncDisplayKit
import Core

class DecorationNode: ASDisplayNode {
    private let model: DecorationModel
    private let decoration: BlockDecoration
    private let maskedLayer = CALayer()
    private let strokeLayer = CAShapeLayer()
    
    init(model: DecorationModel, decoration: BlockDecoration) {
        self.model = model
        self.decoration = decoration
        super.init()
        
        strokeLayer.strokeColor = model.border?.color.CGColor
        strokeLayer.lineWidth = model.border?.width ?? 0
        maskedLayer.backgroundColor = model.color.CGColor
    }
    
    override func didLoad() {
        super.didLoad()
        layer.addSublayer(maskedLayer)
        maskedLayer.backgroundColor = model.color.CGColor
        if let border = model.border where decoration != .None {
            strokeLayer.strokeColor = border.color.CGColor
            strokeLayer.fillColor = UIColor.clearColor().CGColor
            layer.addSublayer(strokeLayer)
        }
        
    }
    
    override var frame: CGRect {
        didSet {
            maskedLayer.frame = bounds
            maskedLayer.mask = model.maskingLayer(forBounds: bounds, decoration: decoration)
            strokeLayer.path = model.strokingPath(forRect: bounds, decoration: decoration)?.CGPath
        }
    }
}
