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


func observableFetchCityData(cityName: String) -> Observable<CityDataForViewModel>{
    return Observable<CityDataForViewModel>.create { emitter in
        let url = "http://api.geonames.org/searchJSON?formatted=true&q=\(cityName)&maxRows=10&lang=es&username=llovretic"
        
        let request = Alamofire.request(url)
        request.validate()
            .responseJSON { response in
                switch response.result
                {
                case .success:
                    let decoder = JSONDecoder()
                    let jsonData = response.data
                    do{
                        let data = try decoder.decode(CityDataForViewModel.self, from: jsonData!)
                        emitter.onNext(data)
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


