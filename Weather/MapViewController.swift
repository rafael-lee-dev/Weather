//
//  MapViewController.swift
//  Weather
//
//  Created by Sousuke Tanaka on 11/1/17.
//  Copyright © 2017 Sousuke Tanaka. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var coordinate: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mapView.isUserInteractionEnabled = true
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(doubleTapMapView))
        tapGesture.numberOfTapsRequired = 2
        tapGesture.numberOfTouchesRequired = 1
        self.mapView.subviews[0].addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doubleTapMapView(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.mapView)
        self.coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
        self.performSegue(withIdentifier: "SegueWeather", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if destination.isKind(of: WeatherViewController.classForCoder()) {
            (destination as! WeatherViewController).coordinate = self.coordinate
        }
    }
}
