//
//  VideoOverlayNode.swift
//  NRC
//
//  Created by Taco Vollmer on 24/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

struct VideoOverlayNodeContent {
    let placeholder: Image
    let playButtonImage: UIImage
    let title: NSAttributedString?
    
    private var imageNodeContent: ImageNodeContent {
        let gradient = LinearGradient(colors: [.clearColor(), .blackColor()])
        return ImageNodeContent(image: placeholder, gradient: gradient, backgroundColor: .clearColor())
    }
}

class VideoOverlayNode: ASControlNode {
    let placeholderNode: ImageNode
    let playButtonNode: ASImageNode
    let titleNode: ASTextNode?
    let content: VideoOverlayNodeContent
    
    init(content: VideoOverlayNodeContent) {
        self.content = content
        
        // placeholder
        placeholderNode = ImageNode(content: content.imageNodeContent)
        placeholderNode.userInteractionEnabled = false
        
        // play button
        playButtonNode = ASImageNode(image: content.playButtonImage)
        
        // title
        titleNode = ASTextNode(text: content.title)
        super.init()
        
        addSubnode(placeholderNode)
        addSubnode(playButtonNode)
        addOptionalSubnode(titleNode)
    }
    
    /** Optional initializer. Convenient for initializing optional `VideoOverlayNode`s in containing nodes */
    convenience init?(optionalContent: VideoOverlayNodeContent?) {
        guard let content = optionalContent else { return nil }
        self.init(content: content)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let playButtonSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: playButtonNode)
        
        var contentSpec: ASLayoutSpec = playButtonSpec
        if let titleNode = titleNode {
            let spacer = ASLayoutSpec()
            spacer.flexGrow = true
            titleNode.spacingAfter = 12
            let titleSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .End, alignItems: .Center, children: [spacer, titleNode])
            contentSpec = ASOverlayLayoutSpec(child: playButtonSpec, overlay: titleSpec)
        }
        
        return ASOverlayLayoutSpec(child: placeholderNode, overlay: contentSpec)
    }
    
    //MARK - Highlighting
    func highlightPlayButton(highlighted: Bool) {
        let alpha: CGFloat = highlighted ? 0.5 : 1
        let duration: NSTimeInterval = highlighted ? 0.1 : 0.4
        UIView.animateWithDuration(duration,
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: { self.playButtonNode.alpha = alpha },
                                   completion: nil
        )
    }
}
