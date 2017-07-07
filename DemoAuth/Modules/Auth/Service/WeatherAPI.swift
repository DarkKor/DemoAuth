//
//  WeatherAPI.swift
//  DemoAuth
//
//  Created by Dmitriy on 08.07.17.
//  Copyright © 2017 GrowApp Solutions. All rights reserved.
//

import UIKit

class WeatherAPI {
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "21e9f7966e225caee317567025b868d9"
    
    static let shared: WeatherAPI = {
        return WeatherAPI()
    }()
    
    fileprivate init() {
    }
    
    func getWeather(_ completion: @escaping ([String: Any]?)->()) {
        request("\(baseURL)?APPID=\(apiKey)&q=Moscow").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                completion(json as? [String: Any])
            case .failure:
                completion(nil)
            }
        }
    }
}
