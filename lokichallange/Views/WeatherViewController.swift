//
//  WeatherViewController.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var weather: UILabel!
    
    var coordinate : Coordinate?
    let viewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let coordinate = coordinate else { return }
        
        viewModel.delegate = self
        viewModel.setCoordinate(coordinate)
    }
}

// MARK: WeatherViewModelDelegate

extension WeatherViewController: WeatherViewModelDelegate {
    func setCityNameText(_ text: String) {
        location.text = text
    }
    
    func setTemperatureText(_ text: String) {
        temperature.text = text
    }
    
    func setDescriptionText(_ text: String) {
        weather.text = text
    }
}
