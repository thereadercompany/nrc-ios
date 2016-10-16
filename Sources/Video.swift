//
//  Video.swift
//  NRC
//
//  Created by Taco Vollmer on 13/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation

struct Video {
    let image: Image
    let URL: NSURL
    
    var aspectRatio: CGFloat {
        return image.aspectRatio
    }
}

struct StreamingVideo {
    let image: Image
    let identifier: String
}

typealias Playlist = String
