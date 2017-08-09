//
//  AddCustomAmmenityTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/9/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class AddCustomAmmenityTableViewController: UITableViewController {
    
    var customAmenities = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddAmenityTableViewCell
        cell.hideTextField()
        
        cell.delegate = self

        return cell
    }


   

}


extension AddCustomAmmenityTableViewController: addToCustomAmenitiesDelegate {
    
    func addAmenity(with amenity: String, for cell: UITableViewCell) {
        
        
      let index = tableView.indexPath(for: cell)
        
        // add and remove then reload table view
        print("here is the index \(index?.row)")
        
        
        
    }
    
    
    
}
