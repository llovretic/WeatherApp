//
//  WeatherDataForViewModel.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

class WeatherDataForViewModel: Decodable {
    var currently: CurrentWeather?
    var daily: DailyWeather
}
