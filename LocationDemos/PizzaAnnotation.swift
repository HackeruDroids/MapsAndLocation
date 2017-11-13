//
//  PizzaAnnotation.swift
//  LocationDemos
//
//  Created by hackeru on 24 Heshvan 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//
	
import UIKit
import MapKit

class PizzaAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title:String?, subtitle: String?){
        self.subtitle = subtitle
        self.title = title
        self.coordinate = coordinate
    }
    
    
    

}
