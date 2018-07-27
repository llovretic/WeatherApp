//
//  ScreenViewModel.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel{
    let dataIsReady = PublishSubject<Bool>()
    let downloadTrigger = PublishSubject<Bool>()
    let errorOccured = PublishSubject<Bool>()
    var city = City()
    var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    var searchCoordinatorDelegate: DissmissCoordinatorDelegate?
    
    
    func initializeObservableCityDataAPI() -> Disposable {
        let downloadObserver = downloadTrigger.flatMap { (_) ->  Observable<GeoNamesOld> in
            return GeoNamesServices().observableFetchCityData(cityName: "Osijek")
        }
        return downloadObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({ [unowned self] (data) -> DataAndErrorWrapper<City> in
                self.city.cityname = data.asciiName
                self.city.latitute = data.lat
                self.city.longitude = data.lng
                return DataAndErrorWrapper(data: self.city, error: nil)
            })
            .catchError({ (error) -> Observable<DataAndErrorWrapper<City>> in
                return Observable.just(DataAndErrorWrapper(data: self.city, error: error.localizedDescription))
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
    
    func cancelSearchViewController(){
        self.searchCoordinatorDelegate?.dissmissViewController()
    }
    
    func triggerGeoDownload(){
        self.downloadTrigger.onNext(true)
    }
}
