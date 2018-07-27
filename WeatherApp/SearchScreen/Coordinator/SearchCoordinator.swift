//
//  SearchCoordinator.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    let controller: SearchViewController
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?

    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewController.searchViewModel = searchViewModel
        self.controller = searchViewController
    }
    
    func start() {
        presenter.present(controller, animated: true)
    }
    
    
}
