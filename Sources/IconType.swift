//
//  IconType.swift
//  ios-nrc-nl
//
//  Created by Taco Vollmer on 02/12/15.
//  Copyright © 2015 NRC Media. All rights reserved.
//

import Foundation
import Argo
import AsyncDisplayKit

protocol IconType : Decodable, RawRepresentable {
    var image: UIImage { get }
}

extension IconType {
    var image: UIImage {
        return UIImage(named: "icon-\(rawValue)")!
    }
}

enum MediaIcon: String, IconType {
    case Video = "video"
    case Photo = "photo"
    case Infographic = "infographic"
    case Unknown = "unknown"
    case Broken = "broken"
    case Alert = "alert"
    case Document = "document"
    case Map = "map"
    case Audio = "audio"
    
    static func decode(json: JSON) -> Decoded<MediaIcon> {
        guard case .String(let string) = json, let icon = self.init(rawValue: string) else {
            return .Failure(.TypeMismatch(expected: "String", actual: json.description))
        }
        return .Success(icon)
    }
}

enum InlineIcon: String, IconType {
    case Clock = "clock"
    case Pen = "pen"
}