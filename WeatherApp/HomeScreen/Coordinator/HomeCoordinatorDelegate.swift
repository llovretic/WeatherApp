//
//  HomeCoordinatorDelegate.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func openSearchScreen()
    func openSettingsScreen()
}
