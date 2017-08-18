//
//  listType.swift
//  Apt
//
//  Created by Michael Metzger  on 8/17/17.
//  Copyright © 2017 Metzger. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ListType {
    
    var listName: String
    var assignedUnits: [String]
    
    
    init(listName: String, assignedUnits: [String]) {
        self.listName = listName
        self.assignedUnits = assignedUnits
 
    }
    

}



func currentListTypeArray(dictionary: [String : Any]) -> [ListType]?  {

    let json = JSON(dictionary)
    
    guard let savedLists = json[PropertyKeys.SavedLists.rawValue].dictionaryObject else {return nil }
    var arrayToReturn = [ListType]()
    
    for (key, value) in savedLists {
        if let newArray = value as? [String] {
            let newList = ListType(listName: key, assignedUnits: newArray)
            arrayToReturn.append(newList)
        }

        
    }
    
    return arrayToReturn
    
}
