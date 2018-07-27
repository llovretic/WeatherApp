//
//  Home.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

enum icon : String {
    case clearDay = "clear-day"
    case clearNight = "clear-ight"
    case cloudy = "cloudy"
    case fog = "fog"
    case hail = "hail"
    case partiallyCloudyDay = "partly-cloudy-day"
    case partiallyCloudyNight  = "partly-cloudy-night"
    case rain = "rain"
    case sleet = "sleet"
    case snow = "snow"
    case thunderstorm = "thunderstorm"
    case wind = "wind"
    case tornado = "tornado"
    
    func values () -> (bodyImage: UIImage, headerImage: UIImage, color: UIColor){
        switch self {
        case .clearDay:
            return (bodyImage: #imageLiteral(resourceName: "body_image-clear-day"), headerImage: #imageLiteral(resourceName: "header_image-clear-day"), color: UIColor(red:0.35, green:0.72, blue:0.88, alpha:1.0))
        case .clearNight :
            return (bodyImage: #imageLiteral(resourceName: "body_image-clear-night"), headerImage: #imageLiteral(resourceName: "header_image-clear-night"), color: UIColor(red:0.02, green:0.27, blue:0.39, alpha:1.0))
        case .rain:
            return (bodyImage: #imageLiteral(resourceName: "body_image-rain"), headerImage: #imageLiteral(resourceName: "header_image-rain"), color: UIColor(red:0.08, green:0.35, blue:0.48, alpha:1.0))
        case .snow:
            return (bodyImage: #imageLiteral(resourceName: "body_image-snow"), headerImage: #imageLiteral(resourceName: "header_image-snow"), color: UIColor(red:0.04, green:0.23, blue:0.31, alpha:1.0))
        case .sleet:
            return (bodyImage: #imageLiteral(resourceName: "body_image-sleet"), headerImage: #imageLiteral(resourceName: "header_image-sleet"), color: UIColor(red:0.04, green:0.23, blue:0.31, alpha:1.0))
        case .wind:
            return (bodyImage: #imageLiteral(resourceName: "body_image-wind"), headerImage: #imageLiteral(resourceName: "header_image-wind"), color: UIColor(red:0.35, green:0.72, blue:0.88, alpha:1.0))
        case .fog :
            return (bodyImage: #imageLiteral(resourceName: "body_image-fog"), headerImage: #imageLiteral(resourceName: "header_image-fog"), color: UIColor(red:0.67, green:0.84, blue:0.91, alpha:1.0))
        case .cloudy :
            return (bodyImage: #imageLiteral(resourceName: "body_image-cloudy"), headerImage: #imageLiteral(resourceName: "header_image-cloudy"), color: UIColor.gray)
        case .partiallyCloudyDay:
            return (bodyImage: #imageLiteral(resourceName: "body_image-partly-cloudy-day"), headerImage: #imageLiteral(resourceName: "header_image-partly-cloudy-day"), color: UIColor.lightGray)
        case .partiallyCloudyNight:
            return (bodyImage: #imageLiteral(resourceName: "body_image-partly-cloudy-night"), headerImage: #imageLiteral(resourceName: "header_image-partly-cloudy-night"), color: UIColor.darkGray)
        case .hail :
            return (bodyImage: #imageLiteral(resourceName: "body_image-hail"), headerImage: #imageLiteral(resourceName: "header_image-hail"), color : UIColor(red:0.04, green:0.23, blue:0.31, alpha:1.0))
        case .thunderstorm:
            return (bodyImage: #imageLiteral(resourceName: "body_image-thunderstorm"), headerImage: #imageLiteral(resourceName: "header_image-thunderstorm"), color: UIColor(red:0.04, green:0.23, blue:0.31, alpha:1.0))
        case .tornado:
            return (bodyImage: #imageLiteral(resourceName: "body_image-tornado"), headerImage: #imageLiteral(resourceName: "header_image-tornado"), color: UIColor(red:0.35, green:0.72, blue:0.88, alpha:1.0))
        }
    }
}

