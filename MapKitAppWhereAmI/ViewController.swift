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
    
    @IBOutlet var myMap: MKMapView!
    
    var manager = CLLocationManager()
    

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
        longPress.minimumPressDuration = 0.1
        myMap.addGestureRecognizer(longPress)
        // ---------------- LongPress Gesture Implementation ------------------

    
    
    
    
    
    }
    
    // ---------------- LongPress Action Function  ------------------
    func action(gestureRecognizer:UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.locationInView(self.myMap)
        let newLocation:CLLocationCoordinate2D = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
        let longPressAnn = MKPointAnnotation()
        longPressAnn.title = "This is a second title"
        longPressAnn.subtitle = "This is a second subtitle"
        myMap.addAnnotation(longPressAnn)
    }
    // ---------------- LongPress Action Function  ------------------

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

