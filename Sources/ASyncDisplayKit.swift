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
    /** Initializer that sets the `attributedText` property to `text`
     - parameter text: attributed string to initialize the `ASTextNode` with
     - returns: An initialized `ASTextNode` with `attributedText` property set to `text`
     */
    convenience init(text: NSAttributedString) {
        self.init()
        attributedText = text
    }
    /**
     Optional initializer that returns `nil` when `text` is `nil`.
     This makes it more convenient to initialize an optional `ASTextNode` in containing nodes
     - parameter optionalText: optional attributed string to initialize the `ASTextNode` with
     - returns: `nil` if `text` is `nil` else an initialized `ASTextNode` with `attributedText` property set to `text`
     */
    convenience init?(optionalText: NSAttributedString?) {
        guard let text = optionalText else { return nil }
        self.init(text: text)
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
    convenience init?(optionalImage: Image?) {
        guard let image = optionalImage else { return nil }
        self.init(image: image)
    }
}

extension ASImageNode {
    /** Convenience initializer that initializes the `ASImageNode` and assigns `image` to it's `image` property
     - parameter image: UIImage object to initialize the `ASImageNode` with
     - returns: An initialized `ASImageNode` with it's `image` property set to `image`
     */
    convenience init(image: UIImage) {
        self.init()
        self.image = image
    }
    
    /**
     Optional initializer that returns `nil` when `image` is `nil`.
     This makes it more convenient to initialize an optional `ASImageNode` in containing nodes
     - parameter optionalImage: optional `UIImage` to initialize the `ASImageNode` with
     - returns: `nil` if `image` is `nil` else an initialized `ASImageNode` with it's `image` property set to `image`
     */
    convenience init?(optionalImage: UIImage?) {
        guard let image = optionalImage else { return nil }
        self.init(image: image)
    }
}

extension ASButtonNode {
    convenience init(image: UIImage) {
        self.init()
        self.imageNode.image = image
    }
    /**
     Optional initializer that returns `nil` when `image` is `nil`.
     This makes it more convenient to initialize an optional `ASButtonNode` in containing nodes
     - parameter image: optional `UIImage` to initialize the `ASButtonNode`'s `imageNode` with
     - returns: `nil` if `image` is `nil` else an initialized `ASButtonNode` with it's `imageNode.image` property set to `image`
     */
    convenience init?(optionalImage: UIImage?) {
        guard let image = optionalImage else { return nil }
        self.init(image: image)
    }
}

//MARK: - ASDisplayNode + optional subnode
extension ASDisplayNode {
    /** Adds `node` as subnode if it is not `nil`
     
    - returns: the `node` input parameter for if-/guard-let kind of constructions
     
         
      if let node = addOptionalSubnode(optionalNode) {
          do something with unwrapped node
      }
     */
    func addOptionalSubnode<T: ASDisplayNode>(node: T?) -> T? {
        if let node = node {
            addSubnode(node)
        }
        
        return node
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
    convenience init?(optionalGradient: LinearGradient?) {
        guard let gradient = optionalGradient else {
            return nil
        }
        
        self.init(gradient: gradient)
    }
}

//MARK: - ASDisplayKit + Line
extension ASDisplayNode {
    /** Creates an `ASDisplayNode` with it's `backgroundColor` set to `line.color`
     - parameter line: The line to initialize the `ASDisplayNode`'s `backgroundColor` with
     - returns: An initialized `ASDisplayNode`
     */
    convenience init(line: Line) {
        self.init()
        backgroundColor = line.color
    }

    /**
     Optional initializer that returns `nil` if the `line` parameter is `nil`.
     This makes it more convenient to initialize an optional line node in containing nodes
     - parameter line: Optional `Line` object to initialize the ASDisplayNode with
     - returns: `nil` if `line` is nil else an initialized `ASDisplayNode` with the `backgroundColor` set to `line.color`
     */
    convenience init?(optionalLine: Line?) {
        guard let line = optionalLine else { return nil }
        self.init(line: line)
    }
}

//MARK: - ASStackLauoutSpec + optional children 
extension ASStackLayoutSpec {
    /** Initializer that takes an array  optional children and filters `.None` before initializing with the unwrapped children */
    convenience init(direction: ASStackLayoutDirection,
                     spacing: CGFloat = 0,
                     justifyContent: ASStackLayoutJustifyContent = .Start,
                     alignItems: ASStackLayoutAlignItems = .Start,
                     optionalChildren: [ASLayoutable?]) {
        let children = optionalChildren.flatMap { $0 }
        self.init(direction: direction, spacing: spacing, justifyContent: justifyContent, alignItems: alignItems, children: children)
    }
}

//MARK: - ASVideoNode + stop
extension ASVideoNode {
    func stop() {
        pause()
        reset()
    }
    
    func reset() {
        let start = CMTime(value: 0, timescale: 1)
        player?.seekToTime(start)
    }
}
