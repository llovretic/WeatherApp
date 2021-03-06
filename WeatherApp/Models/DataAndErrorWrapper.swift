//
//  DataAndErrorWrapper.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

struct DataAndErrorWrapper<T> {
    var data: T
    var error: String?
}
