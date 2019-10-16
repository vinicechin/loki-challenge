//
//  MapViewModel.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private let radius: CLLocationDistance = 1000
    private let annotation = MKPointAnnotation()
    
    var delegate: MapViewModelDelegate?
    
    override init() {
        super.init()
        
        setLocationManager()
    }
    
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func didTapLocation(_ location: CLLocationCoordinate2D) {
        let coordRegion = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        
        annotation.coordinate = location
        delegate?.centerPin(coordRegion, annotation: annotation)
    }
    
    func didSelectLocation(_ location: CLLocationCoordinate2D) {
        didTapLocation(location)
        
        let coordinate = Coordinate(latitude: "\(location.latitude)", longitude: "\(location.longitude)")
        
        delegate?.goTo(coordinate)
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            didTapLocation(location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
