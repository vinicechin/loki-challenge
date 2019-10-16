//
//  MapViewController.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var coord : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectLocation))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        view.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocation))
        singleTapGesture.delegate = self
        view.addGestureRecognizer(singleTapGesture)
    }
    
    @objc func didTapLocation(_ sender: UITapGestureRecognizer) {
        let coord = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
        centerMapOnLocation(coord)
    }
    
    @objc func didSelectLocation(_ sender: UITapGestureRecognizer) {
        coord = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
        centerMapOnLocation(coord)
        performSegue(withIdentifier: "goToWeather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WeatherViewController {
            destination.coord = coord
        }
    }
    
    func centerMapOnLocation(_ location: CLLocationCoordinate2D?) {
        guard let location = location else { return }
        
        let radius : CLLocationDistance = 1000
        let coordRegion = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        
        mapView.setRegion(coordRegion, animated: true)
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }


}

extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            centerMapOnLocation(location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
