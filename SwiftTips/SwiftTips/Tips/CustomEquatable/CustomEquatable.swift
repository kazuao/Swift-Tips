//
//  CustomEquatable.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/08.
//

import Foundation
import CoreLocation

struct Author {
    let name: String
}

extension Author: Equatable {
    static func == (lhs: Author, rhs: Author) -> Bool {
        lhs.name == rhs.name
    }
}

//print(authorA == authorB) // Prints: true

struct LocationResponse {
    let latitude: Double
    let longitude: Double
}

let locationResponse = LocationResponse(latitude: 52.371807, longitude: 4.896029)
let location = CLLocationCoordinate2D(latitude: 52.371807, longitude: 4.896029)

func == (lhs: LocationResponse, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
