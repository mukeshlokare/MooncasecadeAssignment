//
//  Constant.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 04/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class Constant: NSObject {

    //All Constants declaration here
    
    static let BOTTOM_PADDING:CGFloat = 64.0
    
    static func isIPad() -> Bool {
        return (UI_USER_INTERFACE_IDIOM() == .pad)
    }
    
}
