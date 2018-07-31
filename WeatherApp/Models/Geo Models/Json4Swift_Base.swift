//
//  GJson4Swift_Base.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
struct Json4Swift_Base : Decodable {
	let totalResultsCount : Int?
	let geonames : [Geonames]?
}
