//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 30/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class SettingsViewModel{
    var cities: [City] = []
    var dataIsReady = PublishSubject<Bool>()
    var realmTrigger = PublishSubject<Bool>()
    var errorOccurd = PublishSubject<Bool>()
    var settingsCoordinatorDelegate: DissmissCoordinatorDelegate?
    var realmServise = RealmSerivce()
    
    
    
    func getStoredCities() -> Disposable {
        let realmObaerverTrigger = realmTrigger
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (event) in
                if event {
                    self.cities.removeAll()
                    let storedCities = self.realmServise.realm.objects(City.self)
                    for element in storedCities {
                        self.cities.append(element)
                        
                    }
                    self.dataIsReady.onNext(true)
                }
            })
        return realmObaerverTrigger
    }
    
    func dissmissTheView() {
        self.settingsCoordinatorDelegate?.dissmissViewController()
    }
    
    func deleteSelectedCity(selectedCity: Int) {
        let cityToRemove = cities[selectedCity]
        if ( self.realmServise.delete(object: cityToRemove) ) {
            self.cities.remove(at: selectedCity)
            self.dataIsReady.onNext(true)
        } else {
            errorOccurd.onNext(true)
        }
        
        
        
    }
    
    
}
