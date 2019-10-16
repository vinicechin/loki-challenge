//
//  WeatherViewModelDelegateProtocol.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import Foundation

protocol WeatherViewModelDelegate {
    func setCityNameText(_ text: String)
    func setTemperatureText(_ text: String)
    func setDescriptionText(_ text: String)
}
