//
//  VideoNode.swift
//  NRC
//
//  Created by Taco Vollmer on 15/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class VideoNodeContent: Content {
    let URL: NSURL
    let placeholder: Image
    let autorepeat: Bool
    let autoplay: Bool
    let controls: Bool
    let title: NSAttributedString?
    
    var playButtonImage: UIImage? {
        return controls ? UIImage(named: "play_btn") : nil
    }
    
    init(URL: NSURL, placeholder: Image, autorepeat: Bool, autoplay: Bool, controls: Bool, title: NSAttributedString?, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.URL = URL
        self.placeholder = placeholder
        self.autorepeat = autorepeat
        self.autoplay = autoplay
        self.controls = controls
        self.title = title
        super.init(backgroundColor: backgroundColor, padding: padding)
    }
}

class VideoNode: ContentNode<VideoNodeContent>, ASVideoNodeDelegate, VisibilityObserver {
    let videoNode = ASVideoNode()
    let playButtonImageNode: ASImageNode?
    
    //MARK: - Initialization
    required init(content: VideoNodeContent) {
        playButtonImageNode = ASImageNode(image: content.playButtonImage)
        
        super.init(content: content)
        
        let asset = AVAsset(URL: content.URL)
        videoNode.asset = asset
        videoNode.shouldAutoplay = false // auto play only when fully visible
        videoNode.shouldAutorepeat = content.autorepeat
        videoNode.gravity = AVLayerVideoGravityResizeAspect
        videoNode.backgroundColor = content.backgroundColor
        videoNode.delegate = self
        
        addSubnode(videoNode)
        
        if let playButtonImageNode = playButtonImageNode {
            addSubnode(playButtonImageNode)
        }
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratio = 1 / content.placeholder.aspectRatio
        let ratioSpec = ASRatioLayoutSpec(ratio: ratio, child: videoNode)
        let paddedSpec =  ASInsetLayoutSpec(insets: content.padding, child: ratioSpec)
        
        var contentSpec: ASLayoutSpec = paddedSpec
        if let playButtonImageNode = playButtonImageNode {
            let playButtonSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .MinimumXY, child: playButtonImageNode)
            let overlaySpec = ASOverlayLayoutSpec(child: paddedSpec, overlay: playButtonSpec)
            contentSpec = overlaySpec
        }
        
        return contentSpec
    }
        
    private func videoNodeIsFullyVisible(inScrollView scrollView: UIScrollView, cellFrame: CGRect) -> Bool {
        let topVisible = scrollView.contentOffset.y <= cellFrame.minY + videoNode.frame.minY
        let bottomVisible = scrollView.contentOffset.y + scrollView.bounds.height >= cellFrame.minY + videoNode.frame.maxY
        return topVisible && bottomVisible
    }
    
    //MARK: VisibilityObserver
    func visibilityChanged(toState state: VisibilityState) {
        guard case .Visible(_ , let fullyVisible) = state else { return }
        
        let playing = videoNode.isPlaying()
        switch (fullyVisible, playing) {
        case (false, true):
            videoNode.pause()
        case (true, false) where content.autoplay:
            videoNode.play()
        default:()
        }
    }
}
