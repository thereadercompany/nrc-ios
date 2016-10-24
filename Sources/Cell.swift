//  Cell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import AsyncDisplayKit
import Core

//TODO: move to Core

/** Conform a `Cell`'s contentNode to this protocol for it to receive visibility changes */
protocol VisibilityObserver {
    func visibilityChanged(centerOffset offset: CGPoint, viewPortSize: CGSize)
}

/** extension on visibility observing ASDisplayNodes that indicates if the observer is fully visible within the viewport */
extension VisibilityObserver where Self: ASDisplayNode {
    func isFullyVisible(centerOffset offset: CGPoint, viewPortSize: CGSize) -> Bool {
        let viewPort = viewPortSize.rect()
        let offsetInViewPort = viewPort.center + offset
        
        var rect = bounds.size.rect()
        rect.center = offsetInViewPort
        
        return viewPort.contains(rect)
    }
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
    
    /** Notifies a visibility observing contentNode with visibility changes */
    public override func cellNodeVisibilityEvent(event: ASCellNodeVisibilityEvent, inScrollView scrollView: UIScrollView?, withCellFrame cellFrame: CGRect) {
        guard case .VisibleRectChanged = event,
            let scrollView = scrollView,
            observer = contentNode as? VisibilityObserver else {
            return
        }
        
        // calculate the center offset of the content node in the coordinate space of the scrollview
        let scrollCenter = scrollView.bounds.center
        let contentCenter = contentNode.frame.center
        let point = scrollView.convertPoint(contentCenter, fromView: view)
        let offset = point - scrollCenter
        
        observer.visibilityChanged(centerOffset: offset, viewPortSize: scrollView.bounds.size)
    }
}

extension CGRect {
    var center: CGPoint {
        get {
            return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
        }
        set {
            self.origin = CGPoint(x: newValue.x - width / 2, y: newValue.y - height / 2)
        }
    }
    
    
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
