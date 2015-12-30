//
//  CoreBlockDecoder.swift
//  boeckler
//
//  Created by Emiel van der Veen on 01/12/15.
//

import Foundation
import Argo

class CustomBlockDecoder : BlockDecoder {
    
    func decode<T: DecodableWithoutContext>(json: JSON, withContext context: BlockContext) -> Decoded<T> {
        return T.decodeWithoutContext(json) <*> pure(context)
    }
    
    func isKnownBlock(type: String) -> Bool {
        return BlockType.all.contains(type)
    }
    
    func decode(json: JSON, blockType: String, forContext context: BlockContext) -> Decoded<Block> {
        
        if context == .Timeline && blockType == BlockType.Fallback {
            return .Failure(.TypeMismatch(expected: "Non-fallback", actual:"Fallback"))
        }
        
        switch blockType {
        case CoreBlockType.ArticleRef:
            let decodedBlock: Decoded<ArticleRefBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.ArticleHeader:
            let decodedBlock: Decoded<ArticleHeaderBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Image:
            let decodedBlock: Decoded<ImageBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Text:
            let decodedBlock: Decoded<TextBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.PlainText:
            let decodedBlock: Decoded<PlainTextBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Streamer:
            let decodedBlock: Decoded<StreamerBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Youtube:
            let decodedBlock: Decoded<YoutubeBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Vimeo:
            let decodedBlock: Decoded<VimeoBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Tweet:
            let decodedBlock: Decoded<TweetBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Spacing:
            let decodedBlock: Decoded<SpacingBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Footer:
            let decodedBlock: Decoded<FooterBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.Divider:
            let decodedBlock: Decoded<DividerBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.UnsupportedContent:
            let decodedBlock: Decoded<UnsupportedContentBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        case CoreBlockType.ServerError:
            let decodedBlock: Decoded<ServerErrorBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        default: // FallbackBlock
            let decodedBlock: Decoded<FallbackBlock> = decode(json, withContext: context)
            return decodedBlock.map{$0}
        }
    }
}
