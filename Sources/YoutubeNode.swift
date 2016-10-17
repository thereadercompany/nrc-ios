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
    typealias Playlist = String
    
    let playlist: Playlist?
    let loop: Bool
    
    init(identifier: String, placeholder: Image, playlist: Playlist?, loop: Bool, title: NSAttributedString?, backgroundColor: UIColor, padding: UIEdgeInsets) {
        self.playlist = playlist
        self.loop = loop
        super.init(identifier: identifier, placeholder: placeholder, title: title, backgroundColor: backgroundColor, padding: padding)
    }
}

/** Node for playing a youtube video */
class YoutubeNode: StreamingVideoNode<YoutubeNodeContent>, YTPlayerViewDelegate {
    
    lazy var youtubeView: YTPlayerView = { [unowned self] in
        let view = YTPlayerView()
        view.frame = self.bounds
        view.delegate = self
        return view
        }()
    
    //MARK: - View animation
    override var videoView: UIView {
        return youtubeView
    }
    
    //MARK: - Initialization
    required init(content: YoutubeNodeContent) {
        super.init(content: content)
    }
        
    //MARK: - Transport
    func loadVideo() {
        youtubeView.load(
            videoId: content.identifier,
            playlistId: content.playlist,
            playerVars: ["showinfo":0, "playsinline":1]
        )
    }
    
    override func play() {
        loadVideo()
        showVideoView()
        switch youtubeView.playerState() {
        case .Paused, .Ended:
            youtubeView.playVideo()
        default: return
        }
    }
    
    override func pause() {
        switch youtubeView.playerState() {
        case .Playing:
            youtubeView.pauseVideo()
        default: return
        }
    }
    
    override func stop() {
        hideVideoView()
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
            hideVideoView()
        }
    }
}
