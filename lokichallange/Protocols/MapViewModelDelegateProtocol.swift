//
//  MapViewModelDelegateProtocol.swift
//  lokichallange
//
//  Created by Vinicius Cechin on 16/10/19.
//  Copyright © 2019 Vinicius Cechin. All rights reserved.
//

import MapKit

protocol MapViewModelDelegate: class {
    func centerPin(_ region: MKCoordinateRegion, annotation: MKPointAnnotation)
    func goTo(_ coordinate: Coordinate)
}
