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
    var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    
    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewController.searchViewModel = searchViewModel
        self.controller = searchViewController
    }
    
    func start() {
        controller.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        controller.searchViewModel.searchCoordinatorDelegate = self
        presenter.present(controller, animated: false)
    }
    
    
}

extension SearchCoordinator: DissmissCoordinatorDelegate {
    func dissmissViewController() {
        self.presenter.dismiss(animated: true, completion: {
            self.homeCoordinatorDelegate?.weatherDownloadTrigger()
            print(self.homeCoordinatorDelegate!)
        })
    }
    
    func viewHasFinished() {
        childCoordinators.removeAll()
    }
}
