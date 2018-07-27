//
//  HomeCoordinator.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    let controller: HomeViewController
    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel()
        homeViewController.homeViewModel = homeViewModel
        self.controller = homeViewController
    }
    
    func start() {
        presenter.present(controller, animated: true)
    }
    
    
}
