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
    case Fullscreen
    
    private var size: CGSize {
        let screen = Screen.size
        let size: CGSize
        switch self {
        case Small:
            size = CGSize(singleDimension: screen.width / 4)
        case Medium:
            size = CGSize(singleDimension: screen.width)
        case Large:
            size = CGSize(singleDimension: screen.height)
        case .Fullscreen:
            size = screen
        }
        
        return size * Screen.scale
    }
    
    private func size(aspectRatio ratio: CGFloat) -> CGSize {
        let width = size.width
        let height = width / ratio
        return CGSize(width: width, height: height)
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
    
    func URL(media media: Media, size: ImageSize, aspectRatio: CGFloat) -> NSURL {
        let size = size.size(aspectRatio: aspectRatio)
        return mediaLocator.URL(media: media, size: size)
    }
    
    // size in points
    func URL(media media: Media, size: CGSize) -> NSURL {
        let sizeInPixels = size.scale(factor: Screen.scale)
        return mediaLocator.URL(media: media, size: sizeInPixels)
    }
}
