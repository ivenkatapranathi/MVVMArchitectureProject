//
//  Properties.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import Foundation

/*
***************************************************
*****************  Properties Model  ***************
***************************************************
*/

struct Properties: Codable {
    let maxSignPhases: Int
    let phaseDwellTime: Int
    let phaseBlankTime: Int
    let maxLinesPerPage: Int
    let maxCharactersPerLine: Int
    let sizeKnown: Bool
}

