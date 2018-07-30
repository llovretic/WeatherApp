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
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let homeViewController = HomeViewController()
        let homeViewModel = HomeViewModel()
        homeViewController.homeViewModel = homeViewModel
        self.controller = homeViewController
    }
    
    func start() {
        controller.homeViewModel.homeCoordinatorDelegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    
}

extension HomeCoordinator: HomeCoordinatorDelegate{
    func openSearchScreen() {
        let coordinator = SearchCoordinator(presneter: presenter)
        coordinator.start()
        coordinator.parentCoordinatorDelegate = self
        self.addChildCoordinator(childCoordinator: coordinator)
    }
    
    func openSettingsScreen() {
        let coordinator = SettingsCoordinator(presneter: presenter)
        coordinator.start()
        coordinator.parentCoordinatorDelegate = self
        self.addChildCoordinator(childCoordinator: coordinator)
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()
    }
    
    
}

extension HomeCoordinator: ParentCoordinatorDelegate{
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(childCoordinator: coordinator)
    }
    
}
