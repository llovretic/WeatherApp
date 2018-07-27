//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable{
    let time: Int
    let summary: String
    let icon: String
    let temperature: Float
    let humidity: Float
    let pressure: Float
    let windSpeed: Float
}
