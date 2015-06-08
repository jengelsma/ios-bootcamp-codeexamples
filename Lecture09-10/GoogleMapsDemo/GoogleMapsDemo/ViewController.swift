//
//  ViewController.swift
//  GoogleMapsDemo
//
//  Created by Jonathan Engelsma on 6/4/15.
//  Copyright (c) 2015 Jonathan Engelsma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        var cameraAllendale = GMSCameraPosition.cameraWithLatitude(42.96356,
            longitude: -85.8899, zoom: 14.7)
        
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: cameraAllendale)
        mapView.settings.compassButton = true
        self.view = mapView
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(42.96356, -85.8899)
        marker.title = "GVSU"
        marker.snippet = "Allendale, MI"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.icon = UIImage(named: "gvsu")
        marker.map = mapView
        
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateLocation(true)
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        updateLocation(false)
        updateLocation(true)
    }

    func updateLocation(running: Bool) {
        let mapView = self.view as! GMSMapView
        let status = CLLocationManager.authorizationStatus()
        if running {
            if (CLAuthorizationStatus.AuthorizedWhenInUse == status) {
                locationManager.startUpdatingLocation()
                mapView.myLocationEnabled = true
                mapView.settings.myLocationButton = true
            }
        } else {
            locationManager.stopUpdatingLocation()
            mapView.settings.myLocationButton = false
            mapView.myLocationEnabled = false
        }
        
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        println("You just tapped the \(marker.title) marker!")
        return false
    }
}

