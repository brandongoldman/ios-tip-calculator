//
//  ViewController.swift
//  Map Playground
//
//  Created by admin on 2/28/20.
//  Copyright © 2020 Brandon Goldman Inc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locMgr : CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            locMgr = CLLocationManager()
            locMgr?.delegate = self
            locMgr?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.userTrackingMode = .follow
        }
    }
    
}

