//  Cell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import AsyncDisplayKit
import Core

//TODO: move to Core

/**
 Cell baseclass for tracking visibility and handling cell actions
 */
public class Cell: ASCellNode, ActionHandler, ActionSender {
    public let contentNode: ASDisplayNode
    public var tracker: Tracker? = nil
    public weak var actionHandler: ActionHandler? {
        didSet {
            if var sender = contentNode as? ActionSender {
                // intercept actions for tracking purposes
                sender.actionHandler = self
            }
        }
    }
    
    //MARK: - Initialization
    public init(contentNode: ASDisplayNode) {
        self.contentNode = contentNode
        
        super.init()
        
        addSubnode(contentNode)
    }
    
    //MARK: - Layout
    override public func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStaticLayoutSpec(children: [contentNode])
    }
    
    //MARK: - ActionHandler
    public func handleAction(action: Action, sender: ActionSender) {
        tracker?.trackTap()
        actionHandler?.handleAction(action, sender: sender)
    }
    
    
    //MARK: - Visibility
    override public func visibilityDidChange(visible: Bool) {
        if visible {
            tracker?.trackVisible()
        } else {
            tracker?.trackInvisible()
        }
    }
}
