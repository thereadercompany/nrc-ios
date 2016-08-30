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

struct ImagePolicy {
    let small = UIScreen.mainScreen().bounds.width / 4
    let medium = UIScreen.mainScreen().bounds.width
    let large = UIScreen.mainScreen().bounds.height

    let mediaLocator: MediaLocator

    func size(block: Block, media: Media, name: String? = nil) -> CGSize {
        switch (block, block.style, name) {
        case (is ArticleRefBlock, BlockStyle.Normal, _):
            return CGSize(singleDimension: medium)
        default:
            return CGSize(singleDimension: large)
        }
    }

    func URL(block: Block, media: Media, name: String? = nil) -> NSURL {
        return mediaLocator.URL(media, size: size(block, media: media, name: name))
    }
}