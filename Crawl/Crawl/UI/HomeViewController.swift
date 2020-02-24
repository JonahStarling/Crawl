//
//  HomeViewController.swift
//  Crawl
//
//  Created by Jonah Starling on 1/20/20.
//  Copyright © 2020 Jonah Starling. All rights reserved.
//

import UIKit
import GoogleMaps
import Kingfisher

class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapView: GMSMapView?
    
    static let locationManager = CLLocationManager()
    
    private var followUser: Bool = true
    private var currentBottomSheet: BottomSheet = ListSelectionViewController(nibName: "ListSelectionViewController", bundle: nil)
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.barListTapped), name: NSNotification.Name(rawValue: "barListTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.crawlListTapped), name: NSNotification.Name(rawValue: "crawlListTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openNewBottomSheet), name: NSNotification.Name(rawValue: "bottomSheetDismissed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openListSelection), name: NSNotification.Name(rawValue: "closeSheet"), object: nil)
        
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
            if let url = URL.init(string: bar.data.pinURL) {
                let resource = ImageResource(downloadURL: url)
                KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                    switch result {
                    case .success(let value):
                        let newWidth = CGFloat.init(60.0)
                        let newHeight = (newWidth / value.image.size.width) * value.image.size.height
                        marker.icon = self.imageWithImage(image: value.image, scaledToSize: CGSize(width: newWidth, height: newHeight))
                    case .failure(_):
                        marker.icon = GMSMarker.markerImage(with: .black)
                    }
                }
            } else {
                marker.icon = GMSMarker.markerImage(with: .black)
            }
            marker.map = mapView
        }
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @objc func barTapped(notif: Notification) {
        if let barId = notif.userInfo?["barId"] as? String {
            if let bar = BarRepository.getBar(id: barId) {
                followUser = false
                mapView?.settings.myLocationButton = !followUser
                mapView?.animate(toLocation: CLLocationCoordinate2D(latitude: CLLocationDegrees(bar.data.lat), longitude: CLLocationDegrees(bar.data.lon)))
                openBarVC(bar: bar)
            }
        }
    }
    
    @objc func crawlTapped(notif: Notification) {
        if let crawlId = notif.userInfo?["crawlId"] as? String {
            if let crawl = CrawlRepository.getCrawl(id: crawlId) {
                openCrawlVC(crawl: crawl)
            }
        }
    }
    
    @objc func barListTapped(notif: Notification) {
        openBarListVC()
    }
    
    @objc func crawlListTapped(notif: Notification) {
        openCrawlListVC()
    }
    
    @objc func openListSelection(notif: Notification) {
        followUser = true
        mapView?.settings.myLocationButton = !followUser
        if let userLocation = HomeViewController.locationManager.location?.coordinate {
            mapView?.animate(toLocation: userLocation)
        }
        openListSelectionVC()
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
        changeBottomSheetView(bottomSheet: barVC)
    }
    
    func openCrawlVC(crawl: Crawl) {
        let crawlVC = CrawlViewController(nibName: "CrawlViewController", bundle: nil)
        crawlVC.crawl = crawl
        changeBottomSheetView(bottomSheet: crawlVC)
    }
    
    func openBarListVC() {
        let barListVC = BarListViewController(nibName: "BarListViewController", bundle: nil)
        changeBottomSheetView(bottomSheet: barListVC)
    }
    
    func openCrawlListVC() {
        let crawlListVC = CrawlListViewController(nibName: "CrawlListViewController", bundle: nil)
        changeBottomSheetView(bottomSheet: crawlListVC)
    }
    
    func openListSelectionVC() {
        let listSelectionVC = ListSelectionViewController(nibName: "ListSelectionViewController", bundle: nil)
        changeBottomSheetView(bottomSheet: listSelectionVC)
    }
    
    func changeBottomSheetView(bottomSheet: BottomSheet) {
        currentBottomSheet.dismissBottomSheet()
        currentBottomSheet = bottomSheet
    }
    
    @objc func openNewBottomSheet() {
        if let currentBottomSheetVC = currentBottomSheet as? UIViewController {
            self.addChild(currentBottomSheetVC)
            self.view.addSubview(currentBottomSheetVC.view)
            currentBottomSheetVC.didMove(toParent: self)

            let height = view.frame.height
            let width  = view.frame.width
            currentBottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        }
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
            mapView?.animate(toLocation: location)
        }
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
