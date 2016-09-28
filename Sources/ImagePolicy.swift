//
//  ImagePolicy.swift
//  boeckler-ios
//
//  Created by Jeroen Vloothuis on 19-08-16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Core

private extension CGSize {
    init(singleDimension dimension: CGFloat) {
        self = CGSize(width: dimension, height: dimension)
    }
}

private extension CGSize {
    func scale(factor factor: CGFloat) -> CGSize {
        let width = self.width * factor
        let height = self.height * factor
        return CGSize(width: width, height: height)
    }
}

enum ImageSize {
    case Small
    case Medium
    case Large
    
    private var size: CGSize {
        let sideLength: CGFloat
        switch self {
        case Small:
            sideLength = UIScreen.mainScreen().bounds.width / 4
        case Medium:
            sideLength = UIScreen.mainScreen().bounds.width
        case Large:
            sideLength = UIScreen.mainScreen().bounds.height
        }
        
        let scaledSideLength = sideLength * UIScreen.mainScreen().scale
        return CGSize(singleDimension: scaledSideLength)
    }
}

struct ImagePolicy {
    let mediaLocator: MediaLocator

    func size(block block: Block, media: Media, name: String? = nil) -> CGSize {
        return ImageSize.Large.size
    }
    
    func URL(block block: Block, media: Media, name: String? = nil) -> NSURL {
        let size = self.size(block: block, media: media, name: name)
        return mediaLocator.URL(media: media, size: size)
    }

    func URL(media media: Media, size: ImageSize) -> NSURL {
        return mediaLocator.URL(media: media, size: size.size)
    }
    
    // size in points
    func URL(media media: Media, size: CGSize) -> NSURL {
        let sizeInPixels = size.scale(factor: UIScreen.mainScreen().scale)
        return mediaLocator.URL(media: media, size: sizeInPixels)
    }
}
