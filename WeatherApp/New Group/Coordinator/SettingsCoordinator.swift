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
    var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    weak var parentCoordinatorDelegate: ParentCoordinatorDelegate?
    
    
    init(presneter: UINavigationController){
        self.presenter = presneter
        let settingsViewController = SettingsViewController()
        let settingsViewModel = SettingsViewModel()
        settingsViewController.settingsViewModel = settingsViewModel
        self.controller = settingsViewController
    }
    
    func start() {
        controller.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        controller.settingsViewModel.settingsCoordinatorDelegate = self
        presenter.present(controller, animated: false)
    }
    
    
}

extension SettingsCoordinator: DissmissCoordinatorDelegate {
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
