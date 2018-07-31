//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(presneter: UINavigationController){
        self.presenter = presneter
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(presneter: presenter)
        homeCoordinator.start()
        self.addChildCoordinator(childCoordinator: homeCoordinator)
    }  
}
