//
//  ListTableViewController.swift
//  Apt
//
//  Created by Michael Metzger  on 8/17/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var  propertyLists = [String]()

    @IBAction func addToList(_ sender: UIBarButtonItem) {
        
        addTextAlert()
        
    }
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
        
        
        return propertyLists.count
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListTableViewCell
        
        let curentList = propertyLists[indexPath.row]
        
        cell.configureCell(newName: curentList)
        
        return cell
        
    }

   

}


extension ListTableViewController {
    
    func addTextAlert() {
        
        
        let textAlert = UIAlertController(title: "Add New Amenity", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let newAenity = textAlert.textFields![0] as UITextField
            
            let newText = newAenity.text
            
            if (newText?.characters.count)! > 0 {

                self.tableView.beginUpdates()
                
                self.propertyLists.insert(newText!, at: 0)

                let indexPath = IndexPath(item: 0, section: 0)
                
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
              
                self.updateFireBase()
                
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        textAlert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter List Name"
        }
        
        textAlert.addAction(saveAction)
        textAlert.addAction(cancelAction)
        
        self.present(textAlert, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: update firebase 
    
    
    func updateFireBase() {
        
        let inputDictionary = [PropertyKeys.SavedLists.rawValue : propertyLists]
        
        Endpoints.appendToExisting(with: Endpoints.lists.url, values: inputDictionary)
        
    }
    
    
    
}

