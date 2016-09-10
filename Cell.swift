//  Cell.swift
//  NRC
//
//  Created by Taco Vollmer on 24/08/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import AsyncDisplayKit
import Core

//TODO: Remove when Cell implementation is ready for core
extension Tracker {
    func trackVisible() {
        
    }
    
    func trackInvisible() {
        
    }
    
    func trackTap() {
        
    }
}

// NRC project level Cell - introduces cell decoration
public class NRCCell: Cell {
    let decoration: Decoration?
    let decorationNode: DecorationNode?
    
    init(contentNode: ASDisplayNode, decoration: Decoration?, delegate: CellDelegate?) {
        self.decoration = decoration
        self.decorationNode = DecorationNode(decoration: decoration)
        
        super.init(contentNode: contentNode, delegate: delegate)
        
        if let decorationNode = decorationNode {
            addSubnode(decorationNode)
        }
    }
    
    override public func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let decorationPadding = decoration?.padding ?? UIEdgeInsets()
        let contentLayoutSpec = contentNode.layoutSpecThatFits(constrainedSize)
        let decoratedContentSpec = ASInsetLayoutSpec(insets: decorationPadding, child: contentLayoutSpec)
        return ASBackgroundLayoutSpec(child: decoratedContentSpec, background: decorationNode)
    }
}


// conform content nodes that should handle a cell action to this protocol and the actions will be handled when tapping it's containing cell
public protocol ActionNode {
    var action: CellAction { get }
}

// Cell baseclass for tracking visibility and handling cell actions
public class Cell: ASCellNode {
    private let contentNode: ASDisplayNode
    private var tracker: Tracker? = nil
    private weak var delegate: CellDelegate?
    
    public init(contentNode: ASDisplayNode, delegate: CellDelegate?) {
        self.contentNode = contentNode
        self.delegate = delegate
        super.init()
        addSubnode(contentNode)
        
        //TODO: why is this necessary ?
        backgroundColor = contentNode.backgroundColor
    }
    
    //MARK: - Layout
    override public func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return contentNode.layoutSpecThatFits(constrainedSize)
    }
    
    //MARK: - Interaction
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent!) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent!) {
        handleTap()
        super.touchesEnded(touches, withEvent: event)
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
    }
    
    func handleTap() {
        tracker?.trackTap()
        
        if let delegate = delegate,
            actionNode = contentNode as? ActionNode {
            delegate.handleCellAction(self, cellAction: actionNode.action)
        }
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
