//
//  Validator.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class Validator: NSObject {

    static func validateText(text : String) -> Bool
    {
        if text.count > 0{
            return true
        }
        return false
    }
}
