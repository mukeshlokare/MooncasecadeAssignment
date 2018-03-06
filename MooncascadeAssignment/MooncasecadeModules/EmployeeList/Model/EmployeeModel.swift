//
//  EmployeeModel.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
import Contacts

struct Employee {
    
    var first_name:String = ""
    var last_name:String = ""
    var position:String = ""
    var contactDetails: ContactDetail?
    var projects : [String]?
    
    var isContactAvilable = false //Check to weather contact avilable or not in the conatact list
    var contact = CNContact() //If Contact avilable in the contact list save it to model
    
    init(jsonDict: anyDict) {
        
        first_name = jsonDict["fname"] as? String ?? ""
        last_name = jsonDict["lname"] as? String ?? ""
        position = jsonDict["position"] as? String ?? ""
        contactDetails = ContactDetail(jsonDict: jsonDict["contact_details"] as! anyDict)
        projects = jsonDict["projects"] as? [String]
    }
}

struct ContactDetail{
    var email:String = ""
    var phone:String = ""
   
    init(jsonDict: anyDict) {
        email = jsonDict["email"] as? String ?? ""
        phone = jsonDict["phone"] as? String ?? ""
    }

}
