//
//  WebServices.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation

class WebServicesConstant {
    
    static func endUrlPath(_ endUrl : APIEndUrl) -> String
    {
        switch endUrl
        {
        case .employee_list:
            return "employee_list"
        }
    }
}

struct WSAPIConst
{
    static var BASEURL = "http://tallinn.jobapp.aw.ee/"
    static let BODY = "body"
    static let ERROR = "error"
    static let WAITING_FOR_NETWORK = "Waiting for Network"
    static let ERROR_MESSAGE = "Error occured. PLease try again later"
}

enum APIEndUrl
{
    case employee_list
}

