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

protocol ActionProvider {
    var action: CellAction? { get }
}

public class NRCCell: ASCellNode {
    private let contentNode: ASDisplayNode
    var tracker: Tracker? = nil
    weak var delegate: CellDelegate?
    
    public init(contentNode: ASDisplayNode, delegate: CellDelegate?) {
        self.contentNode = contentNode
        self.delegate = delegate
        super.init()
        addSubnode(contentNode)
        
        //TODO: why is this necessary ?
        backgroundColor = contentNode.backgroundColor
    }
    
    override public func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return contentNode.layoutSpecThatFits(constrainedSize)
    }
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent!) {
        setHighlighted(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent!) {
        setHighlighted(false)
        handleTap()
        super.touchesEnded(touches, withEvent: event)
    }
    
    override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        setHighlighted(false, animated: false)
        super.touchesCancelled(touches, withEvent: event)
    }
    
    override public func visibilityDidChange(visible: Bool) {
        if visible {
            tracker?.trackVisible()
        } else {
            tracker?.trackInvisible()
        }
    }
    
    func handleTap() {
        tracker?.trackTap()
        
        if let delegate = delegate,
            actionProvider = contentNode as? ActionProvider,
            action = actionProvider.action {
            delegate.handleCellAction(self, cellAction: action)
        }
    }
    
    //MARK: - for subclasses
    func setHighlighted(value: Bool, animated: Bool = true) {}
}
