//
//  GeoNames.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

struct GeoNames: Decodable {
    
    let asciiName : String?
    let lat : String?
    let lng : String?
    let alternateNames : [AlternateNames]?
    
}

struct AlternateNames: Decodable {
    let name : String?
    let lang : String?
}
