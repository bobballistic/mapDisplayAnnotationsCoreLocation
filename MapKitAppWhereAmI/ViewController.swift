//
//  ViewController.swift
//  MapKitAppWhereAmI
//
//  Created by Bob on 25/10/2014.
//  Copyright (c) 2014 BallisticSoft. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var latitudeLable: UILabel!
    @IBOutlet var longitudeLable: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // ---------------- Core Location ------------------
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // ---------------- Core Location ------------------

        
        // ---------------- Set map on screen ------------------
        let theSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location = CLLocationCoordinate2D(latitude: 45.612125, longitude: 22.948280)
        let theRegion = MKCoordinateRegionMake(location, theSpan)
        myMap.setRegion(theRegion, animated: true)
        // ---------------- Set map on screen ------------------

        
        // ---------------- Set annotation ------------------
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "This is a annotation"
        annotation.subtitle = "This is a subtitle"
        myMap.addAnnotation(annotation)
        // ---------------- Set annotation ------------------
        
        // ---------------- LongPress Gesture Implementation ------------------
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 0.5
        myMap.addGestureRecognizer(longPress)
        // ---------------- LongPress Gesture Implementation ------------------
    
        
    }
    
    // ---------------- LongPress Action Function  ------------------
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.locationInView(self.myMap)
        
        let newLocation:CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
        
        let longPressAnn = MKPointAnnotation()
        
        longPressAnn.coordinate = newLocation
        
        longPressAnn.title = "This is a second title"
        
        longPressAnn.subtitle = "This is a second subtitle"
        
        myMap.addAnnotation(longPressAnn)
    }
    // ---------------- LongPress Action Function  ------------------

    // --------------------- Core Location manager function ------------
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println("\(locations)")
        var userLocation:CLLocation = locations[0] as CLLocation
        var latitudeByLocation = userLocation.coordinate.latitude
        var longitudeByLocation = userLocation.coordinate.longitude
        println("\(latitudeByLocation)")
    
        // --------------------- Core Location manager function -------------
    
    //------- Loction Update By CoreLocation -----------------
        let theSpanCore:MKCoordinateSpan = MKCoordinateSpanMake(0.01 , 0.01) //Zoom level
        var locationCore:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeByLocation , longitude: longitudeByLocation) //Coordinates
        let theRegionCore:MKCoordinateRegion = MKCoordinateRegionMake(locationCore, theSpanCore)
        myMap.setRegion(theRegionCore, animated: true)
        println("\(locationCore)")
    //------- Loction Update By CoreLocation ----------------
        
        
    // --------- Location to screen -------
        latitudeLable.text = "\(latitudeByLocation)"
        longitudeLable.text = "\(longitudeByLocation)"
    // --------- Location to screen -------
        
    }
    // --------------------Function to catch any errors --------------
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Location has failed \(error)")
    }
    // --------------------Function to catch any errors --------------


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

