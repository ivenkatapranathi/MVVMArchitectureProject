//
//  Location.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import Foundation

/*
***************************************************
*****************  Location Model  ***************
***************************************************
*/

struct Location: Codable {
    let fips: Int
    let perpendicularRadiansForDirectionOfTravel: Double
    let latitude: Double
    let longitude: Double
    let routeId: String
    let linearReference: Double
    let cityReference: String?
    let locationDescription: String
    let signFacingDirection: String
}
