//
//  MainMapViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 7/25/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MainMapViewController: UIViewController {
    
    
    var unitsForMap = [Apartment]()
    
    
    var propertyEndPoint: DatabaseReference {
        
        return Endpoints.currentUSerProperties.url
        
    }
    
    
    let regionRadius: CLLocationDistance = 1000
   

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        propertyEndPoint.observe(.value, with: { (snapshot) in
            
            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            
            self.unitsForMap = ApartmentArray.init(dictionary: valueDictionary).apartments
            print("units for mappoint \(self.unitsForMap)")
            self.addPins()
            
            
      
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}



extension MainMapViewController: MKMapViewDelegate {
    
    func addPins() {
        
        for unit in self.unitsForMap {
            
            if let logitude = unit.location?.longitude, let latitude = unit.location?.latitude {
                
                let cllocation = CLLocationCoordinate2D(latitude: latitude, longitude: logitude)
                
                 let annotation = MKPointAnnotation()
                annotation.coordinate = cllocation
                
                
                mapView.addAnnotation(annotation)
                
                
            }
            
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        return view
        
    }
    
    
    
}
