//
//  ServiceManager.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class ServiceManager{
    
    static func callToWebService(apiEndUrl : APIEndUrl, param : [String:Any]?,successCompletionHandler: @escaping (_ r: NSDictionary?) -> Void){
        
        let urlPath = URL(string: WSAPIConst.BASEURL + WebServicesConstant.endUrlPath(apiEndUrl))
        
        let request = URLRequest(url: urlPath!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    successCompletionHandler(responseJSON)
                }
            } catch {
                print("Error getting API data: \(error.localizedDescription)")
            }
            
        });
        
        task.resume()
    }
    
}
