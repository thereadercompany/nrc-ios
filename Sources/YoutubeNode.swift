//
//  YoutubeNode.swift
//  NRC
//
//  Created by Taco Vollmer on 13/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import youtube_ios_player_helper

/** Content for the YoutubeNode */
class YoutubeNodeContent: StreamingVideoContent {
    let playlist: String?
    let loop: Bool
    
    init(identifier: String, playlist: String?, loop: Bool, overlayContent: VideoOverlayNodeContent, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.playlist = playlist
        self.loop = loop
        super.init(identifier: identifier, overlayContent: overlayContent, backgroundColor: backgroundColor, padding: padding)
    }
}

/** Node for playing a youtube video */
class YoutubeNode: ContentNode<YoutubeNodeContent>, VideoPlayer, VisibilityObserver, YTPlayerViewDelegate {
    let videoOverlayNode: VideoOverlayNode
    
    lazy var youtubeView: YTPlayerView = { [unowned self] in
        let view = YTPlayerView()
        view.frame = self.bounds
        view.delegate = self
        return view
        }()
    
    //MARK: - Initialization
    required init(content: YoutubeNodeContent) {
        videoOverlayNode = VideoOverlayNode(content: content.overlayContent)
        super.init(content: content)
        
        //overlay
        addSubnode(videoOverlayNode)
    }
    
    //MARK: - Layout
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStaticLayoutSpec(children: [videoOverlayNode])
    }

    //MARK: - Highlight
    override func highlight(highlighted: Bool, animated: Bool = true) {
        videoOverlayNode.highlightPlayButton(highlighted)
    }
    
    //MARK: - Interaction
    override func handleTap() {
        //TODO: check for internet connection
        play()
    }
    
    //MARK: - Loading
    func loadVideo() {
        youtubeView.load(
            videoId: content.identifier,
            playlistId: content.playlist,
            playerVars: ["showinfo":0, "playsinline":1]
        )
    }
    
    //MARK: - VideoPlayer
    var overlayNode: ASDisplayNode? {
        return videoOverlayNode
    }

    var playing: Bool {
        return youtubeView.playerState() == .Playing
    }
    
    func play() {
        if youtubeView.superview == nil {
            view.insertSubview(youtubeView, belowSubview: videoOverlayNode.view)
        }
        
        loadVideo()
        showOverlay(false, animationDuration: 1)
        switch youtubeView.playerState() {
        case .Paused, .Ended:
            youtubeView.playVideo()
        default: return
        }
    }
    
    func pause() {
        switch youtubeView.playerState() {
        case .Playing:
            youtubeView.pauseVideo()
        default: return
        }
    }
    
    /** overrides default implementation that calls pause */
    func stop() {
        showOverlay(true, animationDuration: 1) {
            self.youtubeView.removeFromSuperview()
        }

        switch youtubeView.playerState() {
        case .Playing:
            youtubeView.stopVideo()
        default: return
        }
    }
    
    //MARK: - YTPlayerViewDelegate
    func playerViewDidBecomeReady(playerView: YTPlayerView) {
        youtubeView.setLoop(content.loop)
        youtubeView.playVideo()
    }
    
    func playerView(playerView: YTPlayerView, didChangeToState state: YTPlayerState) {
        if case .Ended = state {
            showOverlay(true, animationDuration: 1)
        }
    }
}
