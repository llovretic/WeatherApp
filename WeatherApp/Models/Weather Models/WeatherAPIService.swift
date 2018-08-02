//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Luka Lovretić on 25/07/2018.
//  Copyright © 2018 Luka Lovretić. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class WeatherAPIService {
    
    func observableFetchWeatherData(latitude: String, longitude: String) -> Observable<WeatherDataForViewModel>{
        return Observable<WeatherDataForViewModel>.create { emitter in
            let url = "https://api.darksky.net/forecast/90b66f55eb12c7ac400c2c75ee5f8337/\(latitude),\(longitude)"
   
            let request = Alamofire.request(url)
            request.validate()
                .responseJSON { response in
                    switch response.result
                    {
                    case .success:
                        let decoder = JSONDecoder()
                        let jsonData = response.data
                        do {
                            let data = try decoder.decode(WeatherDataForViewModel.self, from: jsonData!)
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
                request.cancel ()
            }
        }
    }
}
