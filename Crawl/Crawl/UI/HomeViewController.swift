//
//  HomeViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 1/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadBars), name: NSNotification.Name(rawValue: "allBarsLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.barTapped), name: NSNotification.Name(rawValue: "barTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.crawlTapped), name: NSNotification.Name(rawValue: "crawlTapped"), object: nil)
        
        BarRepository.getAllBars()
        CrawlRepository.getAllCrawls()
        DealRepository.getAllDeals()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        HomeViewController.locationManager.stopUpdatingLocation()
    }
    
    @objc func loadBars(notif: Notification) {
        for bar in Bars.allBars.values {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(bar.data.lat), longitude: CLLocationDegrees(bar.data.lon))
            marker.userData = bar.id
            marker.isFlat = true
            marker.icon = GMSMarker.markerImage(with: .black)
            marker.map = mapView
        }
    }
    
    @objc func barTapped(notif: Notification) {
        if let barId = notif.userInfo?["barId"] as? String {
            print("Bar id: \(barId)")
            // TODO: Load bar
        }
    }
    
    @objc func crawlTapped(notif: Notification) {
        if let crawlId = notif.userInfo?["crawlId"] as? String {
            print("Crawl id: \(crawlId)")
            // TODO: Load crawl
        }
    }
    
    func loadMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 38.0406, longitude: -84.5037, zoom: 12.0)
        let gmsMapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        gmsMapView.delegate = self
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let id = marker.userData as? String {
            print("User tapped \(BarRepository.getBar(id: id)?.data.name ?? "nil")")
        }
        return false
    }
}
