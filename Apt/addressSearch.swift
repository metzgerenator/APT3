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
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var locatons = [String]()
    var cLocations = [CLLocationCoordinate2D]()

    
    
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
                
                var forLocations = [String]()
                var currentCLocations = [CLLocationCoordinate2D]()
                
                for mapItem in results.mapItems {
                    
                    let cpMark = mapItem.placemark as CLPlacemark
                    let addressAtributes = cpMark.addressDictionary
                    let currentCoordinate = mapItem.placemark.coordinate
                    
                    
                    
                    if let city = addressAtributes?["City"], let state = addressAtributes?["State"] {
                        
                        let locationToAdd = "\(city), \(state)"
                        let alreadyIn = forLocations.contains{$0 == locationToAdd}
                        if !alreadyIn {
                            currentCLocations.append(currentCoordinate)
                            forLocations.append(locationToAdd)
                        }
                        
                    }
                    
                }
                
                self.cLocations = currentCLocations
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
        
        let location = locatons[indexPath.row]
        
        cell.textLabel?.text = location
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let location = locatons[indexPath.row]
        let cordinate = cLocations[indexPath.row]
        
        let latitude = cordinate.latitude
        let longitude = cordinate.longitude
        
        // apend locaton here
        
        
    }
    
    
}



















