//
//  MediaPlayer.swift
//  NRC
//
//  Created by Taco Vollmer on 20/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

//MARK: - Media

/** Defines the interface for playing media */
protocol MediaPlayer {
    var autoplay: Bool { get }
    var playing: Bool { get }
    
    func play()
    func pause()
    func stop()
}

/** default implementation for MediaPlayers that don't support autoplay or stop */
extension MediaPlayer {
    var autoplay: Bool {
        return false
    }
    
    func stop() {
        pause()
    }
}

/** default visibility observation behavior for an ASDisplayNode MediaPlayer */
extension MediaPlayer where Self: VisibilityObserver, Self: ASDisplayNode {
    func visibilityChanged(centerOffset offset: CGPoint, viewPortSize: CGSize) {
        let fullyVisible = isFullyVisible(centerOffset: offset, viewPortSize: viewPortSize)
        
        switch (fullyVisible, playing) {
        case (false, true):
            pause()
        case (true, false) where autoplay:
            play()
        default:
            return
        }
    }
}

//MARK: - Video
/** Extends the MediaPlayer interface to a VideoPlayer interface */
protocol VideoPlayer: MediaPlayer {
    var overlayNode: ASDisplayNode? { get }
}

//MARK: VideoPlayer + overlay animation
extension VideoPlayer {
    func showOverlay(visible: Bool, animationDuration: NSTimeInterval, completion: (() -> Void)? = nil) {
        guard let overlayNode = overlayNode else {
            return
        }
        
        let alpha: CGFloat = visible ? 1 : 0
        guard overlayNode.alpha != alpha else {
            return
        }
        
        let animations = {
            overlayNode.alpha = alpha
        }
        
        guard animationDuration > 0 else {
            animations()
            completion?()
            return
        }
        
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: animations) { _ in completion?() }
    }
}
