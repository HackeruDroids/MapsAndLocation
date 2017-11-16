//
//  FirstViewController.swift
//  LocationDemos
//
//  Created by hackeru on 24 Heshvan 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class MapViewController: UIViewController {
    @IBAction func mapLongTapped(_ sender: UILongPressGestureRecognizer) {
        
        let touchLocation = sender.location(in: self.map) //(230, 400)
        let coordinate = map.convert(touchLocation, toCoordinateFrom: map)
        
        print(coordinate.latitude, coordinate.longitude)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
    
    
    
    let geocoder = CLGeocoder()
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
         
            
            geocoder.reverseGeocodeLocation(lastKnownLocation, completionHandler: { (places:[CLPlacemark]?, err) in
                if let err = err{
                    print(err.localizedDescription)
                    return
                }
                
                guard let place:CLPlacemark = places?.first else{return}
                
                
                let addressDict = place.addressDictionary ?? [:]
                
                let city = addressDict["City"] as? String ?? ""
                let street = addressDict["Street"] as? String ?? ""
                let country = addressDict["Country"] as? String ?? ""
                
                //let cityNewApi = place.postalAddress?.city ?? ""
                
                DispatchQueue.main.async {
                    let annotation = PizzaAnnotation(coordinate: lastKnownLocation.coordinate, title: "Pizza", subtitle: "\(street) - \(city) - \(country)")
                    self.map.addAnnotation(annotation)
                }
//                for (key, val) in addressDict{
//                    print(key, ": ", val)
//                }
            })
            
          
            
            
            
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {return nil}
        
//        let pin = MKPinAnnotationView()
//
//        pin.pinTintColor = .blue
//        return pin //TODO: custom annotation.

        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "pizza") as? PizzaAnnotationView
        
        if view == nil{
            view = PizzaAnnotationView(annotation: annotation, reuseIdentifier: "pizza")
        }
        //view?.pinTintColor = .blue
        
        //view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
       
        
        view?.canShowCallout = true //TODO: see a callout
        view?.image = #imageLiteral(resourceName: "icons8-pizza")
        view?.backgroundColor = .clear
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if view is MKPinAnnotationView{
            print("Tapped the callout")
        }
    }
}

//
////
//extension UIViewController: MKMapViewDelegate{
//
//}

