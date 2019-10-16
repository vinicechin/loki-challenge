//
//  MapViewController.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 49.611622, longitude: 6.131935)
        
        centerMapOnLocation(initialLocation)
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let radius : CLLocationDistance = 1000
        let coordRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        
        mapView.setRegion(coordRegion, animated: true)
    }


}

