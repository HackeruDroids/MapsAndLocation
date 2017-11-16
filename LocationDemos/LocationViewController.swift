//
//  SecondViewController.swift
//  LocationDemos
//
//  Created by hackeru on 24 Heshvan 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

class LocationViewController: UIViewController {
    let geoCoder = CLGeocoder()
    
    @IBAction func search(_ sender: UIButton) {
        guard let text = addressText.text else {return}
        
        geoCoder.geocodeAddressString(text) { (places, err) in
            if let err = err {
                print(err); return
            }
            guard let place = places?.first,
            let lat = place.location?.coordinate.latitude,
            let lng = place.location?.coordinate.longitude
            else {return}
            
            DispatchQueue.main.async {
                self.locationLabel.text = "(\(lat), \(lng))"
            }
        }
    }
    
    @IBOutlet weak var addressText: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
 
        if isLocationEnabled() && hasPermission(){
          requestLocationUpdates()
            
            //lat=32.0844224 lon=34.8007186
            //CLLocationDegrees -> Double.
            //CLLocationDistance -> Double
            let coord = CLLocationCoordinate2D(latitude: 32.0844224, longitude: 34.8007186)
            let circular = CLCircularRegion(center: coord, radius: 10, identifier: "Hackeru")
            circular.notifyOnExit = true
            circular.notifyOnEntry = true
            
            
            
            locationManager.allowsBackgroundLocationUpdates = true
            
            locationManager.startMonitoring(for: circular)
        }
        
        
    }
    


    
    func hasPermission()->Bool{
        //static method
        let status = CLLocationManager.authorizationStatus()
        
        //return true or false
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    
    func isLocationEnabled()->Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    
    
    func requestLocationUpdates(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //GPS
        
       /// locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.startUpdatingLocation()
    }
    
    func requestLocationOnce(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation() //void...
    }
}

extension LocationViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
        
//        locationLabel.text = "(\(locations[0].coordinate.latitude), \(locations[0].coordinate.longitude))"
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if isLocationEnabled() && hasPermission(){
            requestLocationUpdates()
        }

        print("Did Change Auth Status", status)
        
        switch status {
        case .authorizedAlways ,.authorizedWhenInUse:
            print("Authorized")
            //fallthrough
        default:
            print("Not Authorized")
        }
        
//        let url = URL(string: UIApplicationOpenSettingsURLString)!
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(region.identifier)
    }
}
