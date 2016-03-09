//
//  CoreBlockDecoder.swift
//  boeckler
//
//  Created by Emiel van der Veen on 01/12/15.
//

import Foundation
import Argo

class CustomBlockDecoder : BlockDecoder {
    
    func isKnownBlock(type: String) -> Bool {
        return BlockType.all.contains(type)
    }
        
    func decode(json: JSON, blockType: String, forContext context: BlockContext) -> Decoded<Block> {
        
        if context == .Timeline && blockType == BlockType.Fallback {
            return .Failure(.TypeMismatch(expected: "Non-fallback", actual:"Fallback"))
        }
        
        switch blockType {
        case CoreBlockType.ArticleRef:
            return ArticleRefBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.ArticleHeader:
            return ArticleHeaderBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Image:
            return ImageBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Text:
            return TextBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.PlainText:
            return PlainTextBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Streamer:
            return StreamerBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Youtube:
            return YoutubeBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Vimeo:
            return VimeoBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Tweet:
            return TweetBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Spacing:
            return SpacingBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.Divider:
            return DividerBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.UnsupportedContent:
            return UnsupportedContentBlock.decodeWithoutContext(json, context: context)
        case CoreBlockType.ServerError:
            return ServerErrorBlock.decodeWithoutContext(json, context: context)
        default: // FallbackBlock
            return FallbackBlock.decodeWithoutContext(json, context: context)
        }
    }
}
