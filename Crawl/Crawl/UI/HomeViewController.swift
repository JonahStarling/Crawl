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
    
    private var followUser: Bool = true
    private var currentBottomSheetVC: BottomSheetViewController = BarListViewController(nibName: "BarListViewController", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
        openNewBottomSheet()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadBars), name: NSNotification.Name(rawValue: "allBarsLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.barTapped), name: NSNotification.Name(rawValue: "barTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.crawlTapped), name: NSNotification.Name(rawValue: "crawlTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openNewBottomSheet), name: NSNotification.Name(rawValue: "bottomSheetDismissed"), object: nil)
        
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
            marker.icon = GMSMarker.markerImage(with: .black)
            marker.map = mapView
        }
    }
    
    @objc func barTapped(notif: Notification) {
        if let barId = notif.userInfo?["barId"] as? String {
            if let bar = BarRepository.getBar(id: barId) {
                openBarVC(bar: bar)
            }
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
        gmsMapView.settings.myLocationButton = !followUser
        gmsMapView.settings.compassButton = true
        gmsMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 170, right: 0)
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
    
    func openBarVC(bar: Bar) {
        let barVC = BarViewController(nibName: "BarViewController", bundle: nil)
        barVC.bar = bar
        
        changeBottomSheetView(bottomSheetVC: barVC)
    }
    
    func changeBottomSheetView(bottomSheetVC: BottomSheetViewController) {
        currentBottomSheetVC.dismissBottomSheet()
        currentBottomSheetVC = bottomSheetVC
    }
    
    @objc func openNewBottomSheet() {
        self.addChild(currentBottomSheetVC)
        self.view.addSubview(currentBottomSheetVC.view)
        currentBottomSheetVC.didMove(toParent: self)

        let height = view.frame.height
        let width  = view.frame.width
        currentBottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
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
        if followUser {
            guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            animateToLocation(newLocation: location)
        }
    }
    
    func animateToLocation(newLocation: CLLocationCoordinate2D) {
        mapView?.animate(toLocation: newLocation)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        followUser = false
        mapView.settings.myLocationButton = !followUser
        if let id = marker.userData as? String {
            if let bar = BarRepository.getBar(id: id) {
                openBarVC(bar: bar)
            }
        }
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        followUser = true
        mapView.settings.myLocationButton = !followUser
        return false
    }
}
