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

class HomeViewModel {
    let dataIsReady = PublishSubject<Bool>()
    let downloadTrigger = PublishSubject<Bool>()
    let errorOccured = PublishSubject<Bool>()
    var weatherData = WeatherDataToPresent()
    
    
    func initializeObservableWeatherDataAPI() -> Disposable {
        let downloadObserver = downloadTrigger.flatMap { (_) -> Observable<WeatherDataForViewModel> in
            return WeatherAPIService().observableFetchData(latitude: 0, longitude: 0)
        }
        return downloadObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({ [unowned self] (data) -> DataAndErrorWrapper in
                self.weatherData.timeCurrentley = (data.currently?.time)!
                self.weatherData.summary = (data.currently?.summary)!
                self.weatherData.icon = icon(rawValue: (data.currently?.icon)!)
                self.weatherData.temperature = Int((data.currently?.temperature)!.rounded())
                self.weatherData.humidity = (data.currently?.humidity)!*100
                self.weatherData.pressure = Int((data.currently?.pressure)!.rounded())
                self.weatherData.windSpeed = (data.currently?.windSpeed)!
                
                let backgroundData: (bodyImage: UIImage, headerImage: UIImage,color: UIColor) = (self.weatherData.icon?.values())!
                self.weatherData.bodyImage = backgroundData.bodyImage
                self.weatherData.headerImage = backgroundData.headerImage
                self.weatherData.backgroundColor = backgroundData.color
                
                let dailyData = data.daily.data
                for items in dailyData{
                    let dailyItems: DailyData = items
                    self.weatherData.timeDaily = dailyItems.time
                    self.weatherData.temperatureMax = dailyItems.temperatureMax
                    self.weatherData.temperatureMin = dailyItems.temperatureMin
                    
                }
                return DataAndErrorWrapper(data: self.weatherData, error: nil)
            })
            .catchError({ (error) -> Observable<DataAndErrorWrapper> in
                return Observable.just(DataAndErrorWrapper(data: self.weatherData, error: error.localizedDescription))
            })
            .subscribe(onNext: { [unowned self](dataToPresent) in
                if dataToPresent.error == nil {
                    self.dataIsReady.onNext(true)
                }
                else {
                    self.errorOccured.onNext(true)
                }
            })
    }
    
    func checkForWeatherData(){
        self.downloadTrigger.onNext(true)
    }
    
    
    
    
    
    
    
    
}
