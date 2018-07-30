//
//  SettingsCoordinator.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 30/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    let controller: SettingsViewController
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    
    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let settingsViewController = SettingsViewController()
        let settingsViewModel = SettingsViewModel()
        settingsViewController.settingsViewModel = settingsViewModel
        self.controller = settingsViewController
    }
    
    func start() {
        presenter.present(controller, animated: true)
    }
    
    
}
