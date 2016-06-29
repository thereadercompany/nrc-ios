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
    
    func decode(json: JSON, blockType: String, forContext context: BlockContextType) -> Decoded<Block> {
        
        if context == CustomBlockContextType.Timeline && blockType == BlockType.Fallback {
            return Decoded.Failure(.TypeMismatch(expected: "Non-fallback", actual:"Fallback"))
        }
        
        let jsonDecoder = JSONDecoder(json: json)
        if let block = self.decode(jsonDecoder, blockType: blockType, forContext: context) {
            return Decoded.Success(block)
        }
        
        if let error = jsonDecoder.error {
            return Decoded.Failure(error)
        }
        
        return Decoded.Failure(.MissingKey("Unable to decode block with type \(blockType) in context \(context)"))
    }
    
    func decode(decoder: JSONDecoder, blockType: String, forContext context: BlockContextType) -> Block? {
        switch blockType {
        case CoreBlockType.ArticleRef:
            return ArticleRefBlock(decoder: decoder, context: context)
        case CoreBlockType.ArticleHeader:
            return ArticleHeaderBlock(decoder: decoder, context: context)
        case CoreBlockType.Image:
            return ImageBlock(decoder: decoder, context: context)
        case CoreBlockType.Text:
            return TextBlock(decoder: decoder, context: context)
        case CoreBlockType.PlainText:
            return PlainTextBlock(decoder: decoder, context: context)
        case CoreBlockType.Streamer:
            return StreamerBlock(decoder: decoder, context: context)
        case CoreBlockType.Youtube:
            return YoutubeBlock(decoder: decoder, context: context)
        case CoreBlockType.Vimeo:
            return VimeoBlock(decoder: decoder, context: context)
        case CoreBlockType.Tweet:
            return TweetBlock(decoder: decoder, context: context)
        case CoreBlockType.Spacing:
            return SpacingBlock(decoder: decoder, context: context)
        case CoreBlockType.Divider:
            return DividerBlock(decoder: decoder, context: context)
        case CoreBlockType.UnsupportedContent:
            return UnsupportedContentBlock(decoder: decoder, context: context)
        case CoreBlockType.ServerError:
            return ServerErrorBlock(decoder: decoder, context: context)
        default: // FallbackBlock
            return FallbackBlock(decoder: decoder, context: context)
        }
    }
}
