//
//  GeoNamesServices.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 27/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class GeoNamesServices{
    var city: [City] = []
    
    func observableFetchCityData(cityName: String) -> Observable<[City]>{
        return Observable<[City]>.create { emitter in
            let url = "http://api.geonames.org/searchJSON?formatted=true&q=\(cityName)&maxRows=10&lang=es&username=llovretic&style=full"
            
            let request = Alamofire.request(url)
            request.validate()
                .responseJSON { response in
                    switch response.result
                    {
                    case .success:
                        let decoder = JSONDecoder()
                        let jsonData = response.data
                        do{
                            let data = try decoder.decode(Json4Swift_Base.self, from: jsonData!)
                            let geoData = data.geonames
                            for dataOfCities: Geonames in geoData! {
                                let savingArray = City()
                                savingArray.cityname = dataOfCities.asciiName
                                savingArray.latitute = dataOfCities.lat
                                savingArray.longitude = dataOfCities.lng
                                self.city.append(savingArray)
                            }
                            emitter.onNext(self.city)
                            emitter.onCompleted()
                        }
                        catch let error {
                            emitter.onError(error)
                        }
                    case .failure(let error):
                        emitter.onError(error)
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
        
        
        
    }
}


