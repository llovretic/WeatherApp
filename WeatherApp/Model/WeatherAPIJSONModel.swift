//
//  WeatherAPIJSONModel.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

struct WebPageJson: Decodable{
    let latitude: Float
    let longitude: Float
    let currently: CurrentWeather
    let daily: DailyWeather
}



