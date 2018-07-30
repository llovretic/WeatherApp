//
//  WeatherDataToPresent.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDataToPresent  {
    var timeCurrentley: Int? = 0
    var summary: String? = ""
    var icon: icon?
    var temperature: Int? = 0
    var humidity: Float? = 0
    var pressure: Int? = 0
    var windSpeed: Float? = 0
    var timeDaily: Int? = 0
    var temperatureMin: Float? = 0
    var temperatureMax: Float? = 0
    var backgroundColor: UIColor?
    var headerImage: UIImage?
    var bodyImage: UIImage?
    var cityName: String?
}
