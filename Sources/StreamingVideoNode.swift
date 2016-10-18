//
//  StreamingVideo.swift
//  NRC
//
//  Created by Taco Vollmer on 14/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

/** Content for VideoNode */
class StreamingVideoContent: Content {
    let identifier: String
    let placeholder: Image
    let title: NSAttributedString?
    
    init(identifier: String, placeholder: Image, title: NSAttributedString?, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.identifier = identifier
        self.placeholder = placeholder
        self.title = title
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
    
    /** sets up the content for the encapsulated imageNode */
    private var imageNodeContent: ImageNodeContent {
        let gradient = LinearGradient(colors: [.clearColor(), .blackColor()])
        return ImageNodeContent(image: placeholder, gradient: gradient, backgroundColor: .clearColor())
    }
}

/** Abstract base class for showing online video content. Should be subclassed to implement provider specific behavior */
class StreamingVideoNode<C: StreamingVideoContent>: ContentNode<C> {
    let imageNode: ImageNode
    let titleNode: ASTextNode?
    let playButtonImageNode = ASImageNode()
    
    //MARK: - Initialization
    required init(content: C) {
        imageNode = ImageNode(content: content.imageNodeContent)
        titleNode = ASTextNode(text: content.title)
        super.init(content: content)
        
        //image
        imageNode.userInteractionEnabled = false
        addSubnode(imageNode)
        
        //title
        if let titleNode = titleNode {
            addSubnode(titleNode)
        }
        
        // play button
        playButtonImageNode.image = UIImage(named: "play_btn")
        addSubnode(playButtonImageNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let playButtonSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: playButtonImageNode)
        
        var contentSpec: ASLayoutSpec = playButtonSpec
        
        if let titleNode = titleNode {
            let spacer = ASLayoutSpec()
            spacer.flexGrow = true
            let titleSpec = ASStackLayoutSpec(direction: .Vertical, spacing: 0, justifyContent: .End, alignItems: .Center, children: [spacer, titleNode])
            let paddedTitleSpec = ASInsetLayoutSpec(insets: content.padding, child: titleSpec)
            contentSpec = ASOverlayLayoutSpec(child: playButtonSpec, overlay: paddedTitleSpec)
        }
        
        return ASOverlayLayoutSpec(child: imageNode, overlay: contentSpec)
    }
    
    //MARK: -
    
    /** override in subclasses to provide the video view*/
    var videoView: UIView {
        assertionFailure("override in concrete VideoNode subclasses to provide the video view")
        return UIView()
    }
    
    func showVideoView() {
        if videoView.superview == nil {
            videoView.alpha = 0
            view.addSubview(videoView)
        }
        
        animateVideoView(visible: true)
    }
    
    func hideVideoView() {
        animateVideoView(visible: false)
    }
    
    private func animateVideoView(visible visible: Bool) {
        let alpha: CGFloat = visible ? 1 : 0
        guard videoView.alpha != alpha else { return }
        
        let animations = {
            self.videoView.alpha = alpha
        }
        let completion: (Bool -> Void)? = visible ? nil : { finished in
            if finished { self.videoView.removeFromSuperview() }
        }
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: animations, completion: completion)
    }

    //MARK: - Transport
    /** override in subclasses to implement play behavior. Base implementation is empty */
    func play() { }
    
    /** override in subclasses to implement plausing behavior. Base implementation is empty */
    func pause() { }
    
    /** override in subclasses to implement stop behavior. Base implementation is empty */
    func stop() { }
    
    //MARK: - Highlight
    override func highlight(highlighted: Bool, animated: Bool = true) {
        let alpha: CGFloat = highlighted ? 0.5 : 1
        let duration = animated ? (highlighted ? 0.1 : 0.4) : 0
        UIView.animateWithDuration(duration,
                                   delay: 0,
                                   options: .CurveEaseOut,
                                   animations: { self.playButtonImageNode.alpha = alpha },
                                   completion: nil
        )
    }
    
    //MARK: - Visibility
    override func visibilityDidChange(visible: Bool) {
        super.visibilityDidChange(visible)
        if !visible {
            pause()
        }
    }
    
    //MARK: - Interaction
    override func handleTap() {
        //TODO: check for internet connection
        play()
    }
}