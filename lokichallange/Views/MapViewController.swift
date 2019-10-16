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
    
    private let viewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setGestures()
    }
    
    @objc private func didTapLocation(_ sender: UITapGestureRecognizer) {
        let coord = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
        viewModel.didTapLocation(coord)
    }
    
    @objc private func didSelectLocation(_ sender: UITapGestureRecognizer) {
        let coord = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
        viewModel.didSelectLocation(coord)
    }
    
    private func setGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectLocation))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        view.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocation))
        singleTapGesture.delegate = self
        view.addGestureRecognizer(singleTapGesture)
    }
}

// MARK: UIGestureRecognizerDelegate

extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: MapViewModelDelegate
extension MapViewController: MapViewModelDelegate {
    func centerPin(_ region: MKCoordinateRegion, annotation: MKPointAnnotation) {
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func goTo(_ coordinate: Coordinate) {
        guard let navController = navigationController else { return }
        
        if let weatherVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "weatherVC") as? WeatherViewController {
            weatherVC.coordinate = coordinate
            
            navController.pushViewController(weatherVC, animated: true)
        }
    }
}
