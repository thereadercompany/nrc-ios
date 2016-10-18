//
//  BlockContextType.swift
//  NRC
//
//  Created by Taco Vollmer on 18/10/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation
import Core

/** Defines all available context types in this project. In Core these are represented by a String in the Renderable Protocol
 */
enum BlockContextType: String {
    case Timeline = "timelines"
    case Article = "articles"
    case Paywall = "paywalls"
    case Onboarding = "onboardings"
    
    case Unknown = "unknown"
    
    init(context: String) {
        self = BlockContextType(rawValue: context) ?? .Unknown
    }
}

extension Renderable {
    /** Converts Core context `String` to `BlockContextType`*/
    var blockContext: BlockContextType {
        return BlockContextType(context: context)
    }
}
