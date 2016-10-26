//
//  VideoNode.swift
//  NRC
//
//  Created by Taco Vollmer on 15/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

/** Content for the VideoNode */
class VideoNodeContent: Content {
    let URL: NSURL
    let aspectRatio: CGFloat
    let autorepeat: Bool
    let autoplay: Bool
    let overlayContent: VideoOverlayNodeContent?

    init(URL: NSURL,
         aspectRatio: CGFloat,
         autoplay: Bool,
         autorepeat: Bool,
         overlayContent: VideoOverlayNodeContent?,
         backgroundColor: UIColor,
         padding: UIEdgeInsets) {
        self.URL = URL
        self.aspectRatio = aspectRatio
        self.autorepeat = autorepeat
        self.autoplay = autoplay
        self.overlayContent = overlayContent
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class VideoNode: ContentNode<VideoNodeContent>, VideoPlayer, VisibilityObserver, ASVideoNodeDelegate {
    let videoNode = ASVideoNode()
    let videoOverlayNode: VideoOverlayNode?
    
    //MARK: - Init
    required init(content: VideoNodeContent) {
        videoOverlayNode = VideoOverlayNode(optionalContent: content.overlayContent)
        
        super.init(content: content)
        
        let asset = AVAsset(URL: content.URL)
        videoNode.asset = asset
        videoNode.shouldAutoplay = false // auto play only when fully visible
        videoNode.shouldAutorepeat = content.autorepeat
        videoNode.gravity = AVLayerVideoGravityResizeAspect
        videoNode.backgroundColor = content.backgroundColor
        videoNode.delegate = self
        videoNode.userInteractionEnabled = false
        
        addSubnode(videoNode)
        addOptionalSubnode(videoOverlayNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio = 1 / content.aspectRatio
        let ratioSpec = ASRatioLayoutSpec(ratio: ratio, child: videoNode)
        let paddedSpec =  ASInsetLayoutSpec(insets: content.padding, child: ratioSpec)
        
        var contentSpec: ASLayoutSpec = paddedSpec
        if let overlayNode = overlayNode {
            contentSpec = ASOverlayLayoutSpec(child: paddedSpec, overlay: overlayNode)
        }
        
        return contentSpec
    }
    
    //MARK: - Highlight
    override func highlight(highlighted: Bool, animated: Bool = true) {
        videoOverlayNode?.highlightPlayButton(highlighted)
    }
    
    //MARK: - Interaction
    override func handleTap() {
        switch playing {
        case false:
            play()
        case true:
            pause()
        }
    }
    
    //MARK: - VideoPlayer
    var overlayNode: ASDisplayNode? {
        return videoOverlayNode
    }
    
    var autoplay: Bool {
        return content.autoplay
    }
    
    var playing: Bool {
        return videoNode.isPlaying()
    }
    
    func play() {
        showOverlay(false, animationDuration: 1)
        videoNode.play()
    }
    
    func pause() {
        videoNode.pause()
    }
    
    func stop() {
        videoNode.stop()
        showOverlay(true, animationDuration: 1)
    }
    
    //MARK: - ASVideoNodeDelegate
    func videoDidPlayToEnd(videoNode: ASVideoNode) {
        // stop when video is played to the end and autorepeat is off
        if !videoNode.shouldAutorepeat {
            stop()
        }
    }
}
