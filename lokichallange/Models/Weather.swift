//
//  Weather.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Info
}

struct Weather: Decodable {
    let description: String
}

struct Info: Decodable {
    let temp: Double
}
