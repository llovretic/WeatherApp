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
    var configuration: Configuration!
    
    func initializeSettingsConfiguration() {
        configuration = realmServise.getSettingsFromRealm()
    }
    
    func toggleMetric() -> Bool {
        if (realmServise.chechForUpdateSettings(unit: !configuration.unit, humidityBool: configuration.humidityIsHidden, windBool: configuration.windIsHidden, pressureBool: configuration.pressureIsHidden)){
        }
        else
        {
            errorOccurd.onNext(true)
        }
        return !configuration.unit
    }
    
    func toggleImperial() -> Bool{
        if (realmServise.chechForUpdateSettings(unit: !configuration.unit, humidityBool: configuration.humidityIsHidden, windBool: configuration.windIsHidden, pressureBool: configuration.pressureIsHidden)){
        }
        else
        {
            errorOccurd.onNext(true)
        }
        return !configuration.unit
    }
    
    func toggleWind() -> Bool {
        if (realmServise.chechForUpdateSettings(unit: configuration.unit, humidityBool: configuration.humidityIsHidden, windBool: !configuration.windIsHidden, pressureBool: configuration.pressureIsHidden)){
        }
        else
        {
            errorOccurd.onNext(true)
        }
        return !configuration.windIsHidden
    }
    
    func togglePressure() -> Bool {
        if (realmServise.chechForUpdateSettings(unit: configuration.unit, humidityBool: configuration.humidityIsHidden, windBool: configuration.windIsHidden, pressureBool: !configuration.pressureIsHidden)){
        }
        else
        {
            errorOccurd.onNext(true)
        }
        return !configuration.pressureIsHidden
    }
    
    func toggleHumidity() -> Bool {
        if (realmServise.chechForUpdateSettings(unit: configuration.unit, humidityBool: !configuration.humidityIsHidden, windBool: configuration.windIsHidden, pressureBool: configuration.pressureIsHidden)){
        }
        else
        {
            errorOccurd.onNext(true)
        }
        return !configuration.humidityIsHidden
    }
    
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
    
    func deleteSelectedCity(selectedCity: Int) {
        let cityToRemove = cities[selectedCity]
        if ( self.realmServise.delete(object: cityToRemove) ) {
            self.cities.remove(at: selectedCity)
            self.dataIsReady.onNext(true)
        } else {
            errorOccurd.onNext(true)
        }
    }
    
    func citySelected(selectedCty: Int){
        let citySelected = City(value: cities[selectedCty])
        if (self.realmServise.delete(object: cities[selectedCty])){
        }
        else {
            errorOccurd.onNext(true)
        }
        if (self.realmServise.create(object: citySelected)){
        }
        else {
            errorOccurd.onNext(true)
        }
        self.settingsCoordinatorDelegate?.dissmissViewController()
        self.settingsCoordinatorDelegate?.viewHasFinished()
    }
}



