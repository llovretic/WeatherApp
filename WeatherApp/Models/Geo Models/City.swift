//
//  City.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class City: Object {
    @objc dynamic var latitute: String? = ""
    @objc dynamic var longitude: String? = ""
    @objc dynamic var cityname: String? = ""
}
