//
//  PizzaAnnotationView.swift
//  LocationDemos
//
//  Created by hackeru on 27 Heshvan 5778.
//  Copyright © 5778 hackeru. All rights reserved.
//

import UIKit
import MapKit

class PizzaAnnotationView: MKAnnotationView {

    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame.size = CGSize(width: 50, height: 50)
        self.backgroundColor = .clear
        self.canShowCallout = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        #imageLiteral(resourceName: "icons8-pizza").draw(in: rect)
    }
}
