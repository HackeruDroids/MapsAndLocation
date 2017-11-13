//
//  FirstViewController.swift
//  LocationDemos
//
//  Created by hackeru on 24 Heshvan 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = .standard
        case 1:
            map.mapType = .satellite
        case 2:
            map.mapType = .hybrid
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //map.delegate = self
        
        map.showsUserLocation = true
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            
            //the last known location:
            guard let lastKnownLocation = CLLocationManager().location else {return}
            
            let annotation = PizzaAnnotation(coordinate: lastKnownLocation.coordinate, title: "Pizza", subtitle: "Yammi")
            map.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Map Loaded")
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("Location")
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100)
        
        map.setRegion(region, animated: true)
    }
}

//
////
//extension UIViewController: MKMapViewDelegate{
//
//}

