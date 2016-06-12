//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Zeng Qiang on 6/11/16.
//  Copyright © 2016 Zeng Qiang. All rights reserved.
//

import Foundation

struct FacialExpression
{
    enum Eye {
        case Open
        case Close
    }
    enum Mouth: Int {
        case Frown
        case Neutral
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue : rawValue - 1) ?? .Frown
        }
        func happierMouth() -> Mouth {
            return Mouth(rawValue : rawValue + 1) ?? .Smile
        }
    }
    var eye: Eye
    var mouth: Mouth
}