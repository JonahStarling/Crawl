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
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
        loadMap()
        addBottomSheetView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.647457, longitude: -90.257309, zoom: 6.0)
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
    
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let bottomSheetVC = BarViewController()

        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    func getUserLocation() {
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
