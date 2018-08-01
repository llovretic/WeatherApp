//
//  SettingViewCellDelegate.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 31/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

protocol SettingsViewCellDelegate: class {
    func deleteButtonTapped(sender: SettingsTableViewCell)
}