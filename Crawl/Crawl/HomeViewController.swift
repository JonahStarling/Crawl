//
//  HomeViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 1/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMap()
    }
    
    func loadMap() {
        getUserLocation()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 80.20, zoom: 6.0)
        let gmsMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        gmsMapView.isMyLocationEnabled = true
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapView = gmsMapView
    }
    
    func getUserLocation() {
        let locationManager = CLLocationManager()
        if !CLLocationManager.locationServicesEnabled() {
            getLocationPermission(locationManager: locationManager)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func getLocationPermission(locationManager: CLLocationManager) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        animateToLocation(newLocation: location)
    }
    
    func animateToLocation(newLocation: CLLocationCoordinate2D) {
        mapView.animate(toLocation: newLocation)
    }
}
