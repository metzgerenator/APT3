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
    
    let regionRadius: CLLocationDistance = 1000
    
    var locationManager = CLLocationManager()
    
    
    var unitsForMap = [Apartment]()
    
    
    var propertyEndPoint: DatabaseReference {
        
        return Endpoints.currentUSerProperties.url
        
    }
    
    
   

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        propertyEndPoint.observe(.value, with: { (snapshot) in
            
            let valueDictionary = snapshot.value as? [String : Any] ?? [:]
            
            self.unitsForMap = ApartmentArray.init(dictionary: valueDictionary).apartments
            self.addPins()
            self.centerOnMap()
            
            
      
        })

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizaitonStatus()
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
                let unitToAdd = PropertyView.init(unit: unit, latitude: latitude, longitude: logitude)
                
                mapView.addAnnotation(unitToAdd)
               
                
            }
            
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? PropertyView {
            
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -3, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                
                
            }
            
            
        }
        
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        
        return view
        
    }
    
    
    
}



extension MainMapViewController {
    
    
    func centerOnMap() {
        let unit = unitsForMap[0]
        guard let location = unit.location else {return}
        
        let initialLocation = CLLocation(latitude: location.latitude , longitude: location.longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    
    
    func checkLocationAuthorizaitonStatus() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        }
        
    }
    
    
}





