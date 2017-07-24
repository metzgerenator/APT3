//
//  addressSearch.swift
//  Apt
//
//  Created by Michael Metzger  on 7/24/17.
//  Copyright © 2017 Metzger. All rights reserved.
//



import UIKit
import MapKit



class SelectLocationViewController: UIViewController {
    
    
    var delegate: appendToDictionaryDelegate?
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var locatons = [CLPlacemark]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.isToolbarHidden = true
        
        searchBar.delegate = self
        self.searchBar.endEditing(true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }

   
    
    
}

extension SelectLocationViewController: UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let localSearhRequest = MKLocalSearchRequest()
        localSearhRequest.naturalLanguageQuery = searchText
        
        let localSearch = MKLocalSearch(request: localSearhRequest)
        
        if localSearch.isSearching {
            localSearch.cancel()
        } else {
            
            localSearch.start(completionHandler: { (response, error) in
                guard let results = response else { return }
                
                var forLocations = [CLPlacemark]()
                //var currentCLocations = [CLLocationCoordinate2D]()
                
                
                for mapItem in results.mapItems {
                    
                  
                    
                    let cpMark = mapItem.placemark as CLPlacemark

                    
                    forLocations.append(cpMark)
        
                }
                
                //self.cLocations = currentCLocations
                self.locatons = forLocations
                self.tableView.reloadData()
                
            })
        }
        
        
        
    }
    
    
}


extension SelectLocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locatons.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let location = locatons[indexPath.row].addressDictionary
        let fullAddress = postalAddressFromAddressDictionary(location!)
        
        
        cell.textLabel?.text = fullAddress
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = locatons[indexPath.row]
        
        
        let fullAddress = postalAddressFromAddressDictionary(location.addressDictionary!)
        let lattitude = location.location?.coordinate.latitude.description
        let longitude = location.location?.coordinate.longitude.description
        
        let locationDic =  [PropertyKeys.Address.rawValue : fullAddress, PropertyKeys.Latitude.rawValue : lattitude, PropertyKeys.Longitude.rawValue : longitude]
        
        
        delegate?.appender(key: .UserLocation, value: locationDic)
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    
}



//MARK: retrive address

extension SelectLocationViewController {
    
    func postalAddressFromAddressDictionary(_ addressdictionary: [AnyHashable : Any]) -> String {
        
        let street = addressdictionary["Street" as NSObject] as? String ?? ""
        let state = addressdictionary["State" as NSObject] as? String ?? ""
        let city = addressdictionary["City" as NSObject] as? String ?? ""
        //let country = addressdictionary["Country" as NSObject] as? String ?? ""
        let postalCode = addressdictionary["ZIP" as NSObject] as? String ?? ""
        
        return "\(street), \(state), \(city) \(postalCode)"
        
    }

}



















