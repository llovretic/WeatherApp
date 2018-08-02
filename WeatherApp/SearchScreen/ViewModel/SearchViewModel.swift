//
//  SearchViewModel.swift
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
    var loaderControll = PublishSubject<Bool>()
    var city: [City] = []
    var cityName: String!
    var homeCoordinatorDelegate: HomeCoordinatorDelegate?
    var searchCoordinatorDelegate: DissmissCoordinatorDelegate?
    var realmServise = RealmSerivce()
    
    
    func initializeObservableCityDataAPI() -> Disposable {
        let downloadObserver = downloadTrigger.flatMap { (_) ->  Observable<[City]> in
            self.loaderControll.onNext(true)
            self.cityName = self.cityName.replacingOccurrences(of: " ", with: "%20")
            return GeoNamesServices().observableFetchCityData(cityName: self.cityName)
        }
        return downloadObserver
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .map({ (data) -> DataAndErrorWrapper<[City]> in
                return DataAndErrorWrapper(data: data, error: nil)
            })
            .catchError({ (error) -> Observable<DataAndErrorWrapper<[City]>> in
                return Observable.just(DataAndErrorWrapper(data: [], error: error.localizedDescription))
            })
            .subscribe(onNext: { [unowned self](dataToPresent) in
                if dataToPresent.error == nil {
                    self.city = dataToPresent.data
                    self.dataIsReady.onNext(true)
                    self.loaderControll.onNext(false)
                }
                else {
                    self.errorOccured.onNext(true)
                }
            })
    }
    
    func cancelSearchViewController(){
        self.searchCoordinatorDelegate?.dissmissViewController()
        self.searchCoordinatorDelegate?.viewHasFinished()
    }
    
    func triggerGeoDownload(cityName: String){
        self.cityName = cityName
        self.downloadTrigger.onNext(true)
    }
    
    func selectedCityData(selectedCity: Int){
        let citySelectedData = City(value: self.city[selectedCity])
        let realmCityData = realmServise.realm.objects(City.self).filter("cityName=%@", citySelectedData.cityName!)
        for cities in realmCityData{
            if (cities.cityName == citySelectedData.cityName){
                if ( self.realmServise.delete(object: citySelectedData) ){}
                else {
                    errorOccured.onNext(true)
                }
            }
        }
        if ( !self.realmServise.create(object: citySelectedData) ) {
            self.errorOccured.onNext(true)
        }
        cancelSearchViewController()
    }
}
