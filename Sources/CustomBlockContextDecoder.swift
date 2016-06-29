//
//  CustomBlockContextDecoder.swift
//  boeckler-ios
//
//  Created by Emiel van der Veen on 28/06/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import Argo


struct CustomBlockContextType {
    static let Timeline = BlockContextTypes.register("timelines")
}

class CustomBlockContextDecoder: BlockContextDecoder {
    
    func isKnownBlockContext(type: BlockContextType) -> Bool {
        return BlockContextTypes.all.contains(type)
    }
    
    func decode<B: BlockContext>(json: JSON, blocksRelationship: BlocksRelationship, blocks: [Block]) -> Decoded<B> {
        
        let jsonDecoder = JSONDecoder(json: json)
        if let blockContext = B.init(decoder: jsonDecoder, blocksRelationship: blocksRelationship, blocks: blocks) {
            return Decoded.Success(blockContext)
        }
        
        if let error = jsonDecoder.error {
            return Decoded.Failure(error)
        }
        
        return Decoded.Failure(.MissingKey("Unable to decode blockcontext with type \(B.type)"))
    }
}