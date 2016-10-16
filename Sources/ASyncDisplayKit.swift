//
//  ASTextNode.swift
//  NRC
//
//  Created by Taco Vollmer on 08/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

// MARK: - ASTextNode
extension ASTextNode {    
    /**
     Optional initializer that returns `nil` when `text` is `nil`.
     This makes it more convenient to initialize an optional `ASTextNode` in containing nodes
     - parameter text: optional attributed string to initialize the `ASTextNode` with
     - returns: `nil` if `text` is `nil` else an initialized `ASTextNode` with `attributedText` property set to `text`
     */
    convenience init?(text: NSAttributedString?) {
        guard let text = text else { return nil }
        self.init()
        attributedText = text
    }
}

// MARK: - ASNetworkImageNode
extension ASNetworkImageNode {
    /**
     Initializes an ASNetworkImageNode and sets it's `URL` of the `Image` 's `URL`
     - parameter image: An `Image` to initialize the `ASNetworkImageNode` with
     - returns: An initialized `ASNetworkImageNode` with it's `URL` property set to the `image` 's URL
     */
    convenience init(image: Image) {
        self.init()
        self.URL = image.URL
    }
    
    /**
     Optional initializer that returns `nil` when `image` is `nil`.
     This makes it more convenient to initialize an optional `ASNetworkImageNode` in containing nodes
     - parameter image: optional `Image` to initialize the `ASNetworkImageNode` with
     - returns: `nil` if `image` is `nil` else an initialized `ASNetworkImageNode` with it's `URL` property set to the `image` 's URL
     */
    convenience init?(image: Image?) {
        guard let image = image else { return nil }
        self.init(image: image)
    }
}

extension ASImageNode {
    /**
     Optional initializer that returns `nil` when `image` is `nil`.
     This makes it more convenient to initialize an optional `ASImageNode` in containing nodes
     - parameter image: optional `UIImage` to initialize the `ASImageNode` with
     - returns: `nil` if `image` is `nil` else an initialized `ASImageNode` with it's `image` property set to `image`
     */
    convenience init?(image: UIImage?) {
        guard let image = image else { return nil }
        self.init()
        self.image = image
        
    }
}

// MARK: - ASDisplayNode + Gradient
extension ASDisplayNode {
    /**
     Creates an `ASDisplayNode` backed by a `CAGradientLayer`
     - parameter gradient: `LinearGradient` object for configuring the gradient layer with
     - returns: An initialized `ASNetworkImageNode` with a gradient backing layer
     */
    convenience init(gradient: LinearGradient) {
        self.init(layerBlock: {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradient.CGColors
            gradientLayer.startPoint = gradient.start
            gradientLayer.endPoint = gradient.end
            return gradientLayer
        })
    }
    
    /**
     Optional initializer that returns `nil` if the `gradient` parameter is `nil`.
     This makes it more convenient to initialize an optional gradient node in containing nodes
     - parameter gradient: Optional `LinearGradient` object to configure the gradient backing layer with when it's not nil
     - returns: `nil` if `gradient` is nil else an initialized `ASDisplayNode` backed by a `CAGradientLayer`
     */
    convenience init?(gradient: LinearGradient?) {
        guard let gradient = gradient else {
            return nil
        }
        
        self.init(gradient: gradient)
    }
}
