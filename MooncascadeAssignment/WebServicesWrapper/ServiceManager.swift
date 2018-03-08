//
//  ServiceManager.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class ServiceManager{
    
    static func callToWebService(apiEndUrl : APIEndUrl, param : [String:Any]?,successCompletionHandler: @escaping (_ r: NSDictionary?) -> Void, failureCompletionHandler: @escaping (_ r: String) -> Void){
        
        let urlPath = URL(string: WSAPIConst.BASEURL + WebServicesConstant.endUrlPath(apiEndUrl))
        
        let request = URLRequest(url: urlPath!)
        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
        let sessionDelegate = SessionDelegate()
        let session = URLSession(configuration: config, delegate: sessionDelegate, delegateQueue: nil)

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    successCompletionHandler(responseJSON)
                }
            } catch {
                print("Error getting API data: \(error.localizedDescription)")
                failureCompletionHandler("Error")
            }
            
        });
        
        task.resume()
    }
    
}

class SessionDelegate:NSObject, URLSessionDelegate
{
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
        {
            print(challenge.protectionSpace.host)
            if(challenge.protectionSpace.host == "http://tallinn.jobapp.aw.ee/")
            {
                let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
            }
        }
        
    }
}
