//
//  WeatherViewController.swift
//  lokichallange
//
//  Created by Gabriella Barbieri on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "fd3f519c2c560f50d39d6faf3e68ba9b"
    var coord : CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude = String(coord!.latitude)
        let longitude = String(coord!.longitude)
        
        let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Got weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func updateWeatherData(json: JSON) {
        print(json)
    }
}
