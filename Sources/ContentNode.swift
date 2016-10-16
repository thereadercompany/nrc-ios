//
//  ContentNode.swift
//  NRC
//
//  Created by Taco Vollmer on 05/09/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Core

//TODO: Move to Core

/**
 Content base class. Subclass to add additional content. Provides content to `ContentNode`
*/
public class Content {
    public let backgroundColor: UIColor
    public let padding: UIEdgeInsets
    
    public init(backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.backgroundColor = backgroundColor //UIColor.randomColor()
        self.padding = padding
    }
}

/**
 Abstract. Base class for displaying `Content`
*/
public class ContentNode<C: Content>: ASDisplayNode, ActionSender {
    public let content: C

    //MARK - Initialization
    required public init(content: C) {
        self.content = content
        super.init()
        
        backgroundColor = content.backgroundColor
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlight(true)
    }
    
    //MARK: - Interaction
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        highlight(false)
        handleTap()
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        highlight(false)
    }
    
    /** Override in subclasses to customize highlighting. Base implementation is empty */
    public func highlight(highlighted: Bool, animated: Bool = true) { }
    
    /** Override in subclasses to customize tap handling. Base implementation is empty */
    public func handleTap() {}
    
    //MARK - ActionSender
    public weak var actionHandler: ActionHandler?
}