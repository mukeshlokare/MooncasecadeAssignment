//
//  EmployeeDetailViewModel.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation

enum SectionType{
    
    case EmployeeDetails
    case EmployeeProjects
}

struct Section{
    var type: SectionType
}

class EmployeeDetailViewModel: NSObject {
    
    var employeeDetail = [String]()
    
    func employeeDetails(employee:Employee){
        
        if Validator.validateText(text: employee.first_name){
            employeeDetail.append("\(employee.first_name) \(employee.last_name)")
        }
        
        if let email = employee.contactDetails?.email{
            if Validator.validateText(text: email){
                employeeDetail.append("\(email)")
            }
        }
        if let phone = employee.contactDetails?.phone{
            if Validator.validateText(text: phone){
                employeeDetail.append("\(phone)")
            }
        }
      
        if Validator.validateText(text: employee.position){
            employeeDetail.append("\(employee.position)")
        }
    }
}
