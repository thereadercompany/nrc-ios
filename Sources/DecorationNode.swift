//
//  DecorationNode.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

/**
 Model for DecorationNode
 */
struct Decoration {
    let type: DecorationType
    private let layerModel: DecorationLayerModel
    
    init(type: DecorationType, layerModel: DecorationLayerModel) {
        self.type = type
        self.layerModel = layerModel
    }
    
    var padding: UIEdgeInsets {
        return layerModel.padding(type: type)
    }
    
    private func mask(rect rect: CGRect) -> CALayer {
        return layerModel.mask(rect: rect, type: type)
    }
    
    private func strokingPath(rect rect: CGRect) ->  UIBezierPath? {
        return layerModel.strokingPath(rect: rect, type: type)
    }
    
    private var maskedLayer: CALayer {
        return layerModel.maskedLayer
    }
    
    private var strokeLayer: CAShapeLayer? {
        return layerModel.strokeLayer
    }
}

/**
 Node for displaying a frame around content, with optional rounded corners and border
 */
class DecorationNode: ASDisplayNode {
    private let decoration: Decoration
    private let maskedLayer: CALayer
    private let strokeLayer: CAShapeLayer?
    
    init(decoration: Decoration) {
        self.decoration = decoration
        maskedLayer = decoration.maskedLayer
        strokeLayer = decoration.strokeLayer
        
        super.init()
        layer.addSublayer(maskedLayer)
        
        if let strokeLayer = strokeLayer {
            layer.addSublayer(strokeLayer)
        }
    }

    override var frame: CGRect {
        didSet {
            guard frame != CGRect.zero else { return }
            
            maskedLayer.frame = bounds
            strokeLayer?.frame = bounds
            
            maskedLayer.mask = decoration.mask(rect: bounds)
            strokeLayer?.path = decoration.strokingPath(rect: bounds)?.CGPath
        }
    }
    
    convenience init?(optionalDecoration: Decoration?) {
        guard let decoration = optionalDecoration else { return nil }
        self.init(decoration: decoration)
    }
}
