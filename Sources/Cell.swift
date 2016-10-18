//  Cell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import AsyncDisplayKit
import Core

//TODO: move to Core

enum VisibilityState {
    /**  `points = 0` when becoming visible from bottom of scrollView while scrolling downwards.
     `fully` = `true` when both bottom and top of the view are visible */
    case Visible(points: CGFloat, fully: Bool)
    /** both top and bottom of the view are invisible */
    case Invisible
}

/** Conform a contentNode to this protocol to observe visibility state changes */
protocol VisibilityObserver {
    func visibilityChanged(toState state: VisibilityState)
}

/**
 Cell Baseclass for rendering content in a ASCollectionView and tracking visibility
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
    public override func visibilityDidChange(visible: Bool) {
        if visible {
            tracker?.trackVisible()
        } else {
            tracker?.trackInvisible()
        }
    }
    
    /** Notifies an interested contentNode with visibility events */
    private var contentVisible = false
    public override func cellNodeVisibilityEvent(event: ASCellNodeVisibilityEvent, inScrollView scrollView: UIScrollView?, withCellFrame cellFrame: CGRect) {
        guard case .VisibleRectChanged = event,
            let scrollView = scrollView,
            visibilityObserver = contentNode as? VisibilityObserver else {
                return
        }
        
        let contentFrame = view.convertRect(contentNode.frame, toView: scrollView)
        let contentOffset = scrollView.contentOffset
        let bottom = contentFrame.minY - contentOffset.y
        let top = (contentOffset.y + scrollView.bounds.height) - contentFrame.maxY
        
        // check if the contentNode is visible
        guard (top <= contentFrame.origin.y && bottom >= -contentFrame.maxY) &&
              (top >= -contentFrame.maxY && bottom <= contentFrame.origin.y) else {
            // if visible, lower the visible flag and notify observer
            if contentVisible {
                contentVisible = false
                visibilityObserver.visibilityChanged(toState: .Invisible)
            }
            return
        }
        
        // raise visible flag and notify observer
        contentVisible = true
        let points = top + contentFrame.height
        let fullyVisible = (bottom >= 0 && top >= 0)
        visibilityObserver.visibilityChanged(toState: .Visible(points: points, fully: fullyVisible))
    }
}
