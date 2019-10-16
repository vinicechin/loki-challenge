//
//  WeatherViewModel.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct WeatherAPIConstants {
    static let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    static let APP_ID = "fd3f519c2c560f50d39d6faf3e68ba9b"
}

class WeatherViewModel: NSObject {
    
    var delegate: WeatherViewModelDelegate?
    
    func setCoordinate(_ coordinate: Coordinate) {
        let params : [String : String] = ["lat" : coordinate.latitude, "lon" : coordinate.longitude, "appid" : WeatherAPIConstants.APP_ID]
        
        getWeatherData(url: WeatherAPIConstants.WEATHER_URL, parameters: params)
    }
    
    
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            guard response.result.isSuccess else {
                print("Error \(String(describing: response.result.error))")
                return
            }
            
            print("Got weather data successfully!")
            
            let weatherJSON : JSON = JSON(response.result.value!)
            self.updateWeatherData(json: weatherJSON)
        }
    }
    
    func updateWeatherData(json: JSON) {
        
        if let weatherData = try? JSONDecoder().decode(WeatherData.self, from: json.rawData()),
            let firstWeather = weatherData.weather.first {
            delegate?.setCityNameText(weatherData.name)
            delegate?.setDescriptionText(firstWeather.description)
            delegate?.setTemperatureText("\(weatherData.main.temp)")
        }
    }
}
