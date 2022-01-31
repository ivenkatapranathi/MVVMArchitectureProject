//
//  Display.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import Foundation

/*
***************************************************
*****************  Display Model  ***************
***************************************************
*/
struct Display: Codable {
    let pages: [Pages]

    func getDisplayLines() -> String {
        var displayTextString = ""
        for i in 0..<pages.count {
            let lines = pages[i].lines
            for j in 0..<lines.count {
                displayTextString = displayTextString + " " + lines[j]
            }
        }
        return displayTextString
    }
}
