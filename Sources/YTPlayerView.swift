//
//  YTPlayerView.swift
//  NRC
//
//  Created by Taco Vollmer on 13/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import youtube_ios_player_helper

extension YTPlayerView {
    func load(videoId videoId: String?, playlistId: String?, playerVars: [NSObject:AnyObject]) -> Bool {
        switch (videoId, playlistId) {
        case (nil, nil):
            assertionFailure("should have at least one identifier")
            return false
            
        case (.Some(let videoId), nil):
            return loadWithVideoId(videoId, playerVars: playerVars)
            
        case (.Some(let videoId), .Some(let playlistId)):
            var vars = playerVars
            vars["list"] = playlistId
            vars["listType"] = "playlist"
            let params: [NSObject:AnyObject] = ["videoId":videoId, "playerVars":vars]
            return loadWithPlayerParams(params)
            
        case (nil, .Some(let playlistId)):
            return loadWithPlaylistId(playlistId, playerVars: playerVars)
        }
    }
}