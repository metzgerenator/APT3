//
//  Annotations.swift
//  Apt
//
//  Created by Michael Metzger  on 7/25/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import MapKit


struct MapPoints {
    var longitude: Double
    var latitude: Double
    var address: String
}


class Units: NSObject, MKAnnotation {
    
  
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(unit: Apartment, latitude: Double, longitude: Double){
        
       
         let title = unit.apartmentName ?? "no title"
        let addressString = unit.location?.address ?? "no addresss"
        
        self.title = title
        self.subtitle = addressString
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: latitude)
        
        super.init()
        
    }
    
    
}


