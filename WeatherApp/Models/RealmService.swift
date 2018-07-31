//
//  RealmService.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 30/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

class RealmSerivce {
    var realm = try! Realm()
    let errorOccured = PublishSubject<Bool>()
    
    func create<T : City >(object: T) -> Bool {
        do{
            try realm.write {
                realm.add(object)
            }
        }catch {
            return false
        }
        return true
    }
    
    func delete<T: City>(object: T) -> Bool{
        do {
            try realm.write {
                realm.delete(realm.objects(City.self).filter("cityname=%@", object.cityname!))
            }
            
        } catch {
            return false
        }
        return true
    }
    
    func getCityLocations() -> (Observable<DataAndErrorWrapper<[City]>>){
        var cities: [City] = []
        let realmCities = self.realm.objects(City.self)
        for element in realmCities {
            cities += [element]
        }
        return Observable.just(DataAndErrorWrapper(data: cities, error: nil))
    }
    
    
    // ADD FUNCTION FOR SETTINGS OBJECT THAT UPDATES AND CREATES
    
}

