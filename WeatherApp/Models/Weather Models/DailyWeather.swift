//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

struct DailyWeather: Decodable {
    let summary: String
    let icon: String
    let data: [DailyData]
}

struct DailyData: Decodable {
    let time: Int
    let temperatureMin: Float
    let temperatureMax: Float
}
