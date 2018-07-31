//
//  Geonames.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
struct Geonames : Decodable {
	let asciiName : String?
	let lat : String?
	let lng : String?
}
