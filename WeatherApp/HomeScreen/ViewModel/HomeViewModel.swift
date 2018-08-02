//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 26/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Realm
import RealmSwift

class HomeViewModel {
    let dataIsReady = PublishSubject<Bool>()
    let loaderControll = PublishSubject<Bool>()
    let downloadTrigger = PublishSubject<Bool>()
    let errorOccured = PublishSubject<Bool>()
    var weatherData = WeatherDataToPresent()
    var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    var realmService = RealmSerivce()
    var weatherService = WeatherAPIService()
    var settingsConfiguration: Configuration!

    func initializeSettingsConfiguration() {
        if (realmService.realm.objects(Configuration.self).isEmpty == true){
            settingsConfiguration = Configuration()
            if (!realmService.create(object: settingsConfiguration)){
                errorOccured.onNext(true) }
        } else {
            if (settingsConfiguration == nil){
                settingsConfiguration = realmService.getSettingsFromRealm()
            } else {
                if (  !realmService.chechForUpdateSettings(unit: settingsConfiguration.unit, humidityBool: settingsConfiguration.humidityIsHidden, windBool: settingsConfiguration.windIsHidden, pressureBool: settingsConfiguration.pressureIsHidden) ) {
                    errorOccured.onNext(true)
                }
            }            
        }
    }
    
    func initializeObservableWeatherDataAPI() -> Disposable {
        let downloadObserver = downloadTrigger.flatMap { (_) -> Observable<WeatherDataForViewModel> in
            self.loaderControll.onNext(true)
            if ( self.realmService.realm.objects(City.self).isEmpty == true) {
                let latitude = "45.554962"
                let longitude = "18.695514"
                self.weatherData.cityName = "Osijek"
                return self.weatherService.observableFetchWeatherData(latitude: latitude, longitude: longitude)
            }
            else {
                let dataForWeatherAPIService = self.realmService.realm.objects(City.self).last
                self.weatherData.cityName = dataForWeatherAPIService?.cityName
                let longitude = dataForWeatherAPIService?.longitude
                let latitude = dataForWeatherAPIService?.latitute
                return self.weatherService.observableFetchWeatherData(latitude: latitude!, longitude: longitude!)
            }
            
        }
        return downloadObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({ [unowned self] (data) -> DataAndErrorWrapper<WeatherDataToPresent> in
                self.weatherData.timeCurrentley = (data.currently?.time)!
                self.weatherData.summary = (data.currently?.summary)!
                self.weatherData.icon = icon(rawValue: (data.currently?.icon)!)
                self.weatherData.temperature = Int((data.currently?.temperature)!.rounded())
                self.weatherData.humidity = (data.currently?.humidity)!*100
                self.weatherData.pressure = Int((data.currently?.pressure)!.rounded())
                self.weatherData.windSpeed = (data.currently?.windSpeed)!
                
                let backgroundData: (bodyImage: UIImage, headerImage: UIImage,color: UIColor) = self.checkIconData()
                self.weatherData.bodyImage = backgroundData.bodyImage
                self.weatherData.headerImage = backgroundData.headerImage
                self.weatherData.backgroundColor = backgroundData.color
                
                let dailyData = data.daily?.data
                for items in dailyData!{
                    let dailyItems: DailyData = items
                    self.weatherData.timeDaily = dailyItems.time
                    self.weatherData.temperatureMax = dailyItems.temperatureMax
                    self.weatherData.temperatureMin = dailyItems.temperatureMin
                    
                }
                self.weatherData = self.settingsConfiguration.values(weatherObject: self.weatherData)
                return DataAndErrorWrapper(data: self.weatherData, error: nil)
            })
            .catchError({ (error) -> Observable<DataAndErrorWrapper<WeatherDataToPresent>> in
                return Observable.just(DataAndErrorWrapper(data: self.weatherData, error: error.localizedDescription))
            })
            .subscribe(onNext: { [unowned self](dataToPresent) in
                if dataToPresent.error == nil {
                    self.dataIsReady.onNext(true)
                    self.loaderControll.onNext(false)
                }
                else {
                    self.errorOccured.onNext(true)
                }
            })
    }
    
    func checkIconData() -> (bodyImage: UIImage, headerImage: UIImage, color: UIColor) {
        if (self.weatherData.icon == nil){
            self.weatherData.icon = icon(rawValue: "clear-day")
        }
        return self.weatherData.icon!.values()
    }
    
    
    func openSearchScreen(){
        self.homeCoordinatorDelegate?.openSearchScreen()
    }
    
    func openSettingsScreen(){
        self.homeCoordinatorDelegate?.openSettingsScreen()
    }
    
    func checkForWeatherData(){
        self.downloadTrigger.onNext(true)
    }
    
    
    
    
    
    
    
    
}
