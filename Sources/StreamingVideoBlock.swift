//
//  StreamingVideoBlock.swift
//  NRC
//
//  Created by Taco Vollmer on 13/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import UIKit
import Core

/** Abstract model for streaming a video. Subclass to add provider-specific properties */
class StreamingVideoBlock: Block {
    let media: Media
    let movieID: String
    let title: String?
    
    required init?(decoder: JSONDecoder, context: String) {
        media = decoder.value(["attributes", "media"], .null)
        movieID = decoder.value(["attributes", "movie-id"], nullValue: "")
        title = decoder.value(["attributes", "title"])
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}

/** Model for streaming a vimeo movie */
class VimeoBlock: StreamingVideoBlock { }

/** Model for streaming a youtube video */
class YoutubeBlock: StreamingVideoBlock {
    let playlistID: String?
    let loop: Bool
    
    required init?(decoder: JSONDecoder, context: String) {
        playlistID = decoder.value(["attributes", "playlist-id"])
        loop = decoder.value(["attributes", "loop"], false)
        super.init(decoder: decoder, context: context)
        if decoder.error != nil { return nil }
    }
}


