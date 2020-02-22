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
    
    var mapView: GMSMapView?
    
    static let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        addBottomSheetView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLocation()
        
        BarRepository.getAllBars()
        CrawlRepository.getAllCrawls()
        DealRepository.getAllDeals()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        HomeViewController.locationManager.stopUpdatingLocation()
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.0406, longitude: -84.5037, zoom: 12.0)
        let gmsMapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.setMinZoom(12.0, maxZoom: 16.0)
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                gmsMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        mapView = gmsMapView
        view.addSubview(mapView!)
    }
    
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let bottomSheetVC = BarViewController(nibName: "BarViewController", bundle: nil)

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
            getLocationPermission(locationManager: HomeViewController.locationManager)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            HomeViewController.locationManager.delegate = self
            HomeViewController.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            HomeViewController.locationManager.startUpdatingLocation()
            mapView?.animate(toZoom: 14.0)
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
        mapView?.animate(toLocation: newLocation)
    }
}
