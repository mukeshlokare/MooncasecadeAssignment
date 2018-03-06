//
//  EmployeeListViewModel.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
import Contacts

enum EmployeeCategories: String {
    case iOS = "IOS"
    case Android = "ANDROID"
    case Web = "WEB"
    case Sales = "SALES"
    case PM = "PM"
    case Tester = "TESTER"
    case Other = "OTHER"
}

class EmployeeListViewModel: NSObject {
    
    var employeeList = [Employee]()

    func callToGetEmployeeListFromServer(completionHandler: @escaping (_ r: [[Employee]]?,[Employee]?) -> Void){
        
    ServiceManager.callToWebService(apiEndUrl:APIEndUrl.employee_list, param:nil, successCompletionHandler: { (result) in
            print(result!)
            if let response = result{
              let employess = response["employees"] as! [anyDict]
                for employee in employess {
                    self.employeeList.append(Employee(jsonDict: employee))
                }
            completionHandler(self.categorisedEmployeeInTheGroup(),self.employeeList)
                
            }
        })
    }
    
    func categorisedEmployeeInTheGroup()-> [[Employee]]{
        
        var categorisedArray = [[Employee]]()
        var iOSDevs = [Employee]()
        var androidDev = [Employee]()
        var webDev = [Employee]()
        var sales = [Employee]()
        var pm = [Employee]()
        var testers = [Employee]()
        var othere = [Employee]()

        let contacts = fetchContacts()
        
        for var emp in employeeList {

            for contact in contacts{
                
                let contactName = "\(contact.givenName) \(contact.familyName)"
                let empName = "\(emp.first_name) \(emp.last_name)"
                
                print("\(contactName) \n \(empName)")
                if contactName == empName{
                    emp.isContactAvilable = true
                    emp.contact = contact
                }
            }
            
            if emp.position == EmployeeCategories.iOS.rawValue {
                iOSDevs.append(emp)
            }else if emp.position == EmployeeCategories.Android.rawValue{
                androidDev.append(emp)
            }else if emp.position == EmployeeCategories.Web.rawValue{
                webDev.append(emp)
            }else if emp.position == EmployeeCategories.Sales.rawValue{
                sales.append(emp)
            }else if emp.position == EmployeeCategories.PM.rawValue{
                pm.append(emp)
            }else if emp.position == EmployeeCategories.Tester.rawValue{
                testers.append(emp)
            }else if emp.position == EmployeeCategories.Other.rawValue{
                othere.append(emp)
            }
        }
        
        //Sort employees array by lastname
        let sortedAndroidDev = androidDev.sorted(by: { $0.last_name < $1.last_name })
        let sortediOSDevs = iOSDevs.sorted(by: { $0.last_name < $1.last_name })
        let sortedOthere = othere.sorted(by: { $0.last_name < $1.last_name })
        let sortedPm = pm.sorted(by: { $0.last_name < $1.last_name })
        let sortedSales = sales.sorted(by: { $0.last_name < $1.last_name })
        let sortedTesters = testers.sorted(by: { $0.last_name < $1.last_name })
        let sortedWebDev = webDev.sorted(by: { $0.last_name < $1.last_name })

        // Setup employee category array assending order
        categorisedArray.append(sortedAndroidDev)
        categorisedArray.append(sortediOSDevs)
        categorisedArray.append(sortedOthere)
        categorisedArray.append(sortedPm)
        categorisedArray.append(sortedSales)
        categorisedArray.append(sortedTesters)
        categorisedArray.append(sortedWebDev)
        
        return categorisedArray
    }
    
    func fetchContacts() -> [CNContact]{
        
        let contacts: [CNContact] = {
            let contactStore = CNContactStore()
            let keysToFetch = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactEmailAddressesKey,
                CNContactPhoneNumbersKey,
                CNContactImageDataAvailableKey,
                CNContactThumbnailImageDataKey] as [Any]
            
            // Get all the containers
            var allContainers: [CNContainer] = []
            do {
                allContainers = try contactStore.containers(matching: nil)
            } catch {
                print("Error fetching containers")
            }
            
            var results: [CNContact] = []
            
            // Iterate all containers and append their contacts to our results array
            for container in allContainers {
                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                
                do {
                    let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                    results.append(contentsOf: containerResults)
                } catch {
                    print("Error fetching results for container")
                }
            }
            
            return results
        }()
        
        return contacts
    }
    
}
