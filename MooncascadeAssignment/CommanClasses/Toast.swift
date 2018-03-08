//
//  Toast.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 08/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class Toast: NSObject {

    //MARK:- Toast Message
    
    public func showToast(message : String, vc:UIViewController) {
        
        var toastLabel = UILabel()
        if Constant.isIPad() {
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 15.0)
        }else{
            toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        }
        
        let size:CGSize = getTextContentSize(font: toastLabel.font, textString:message, vc:vc)
        let width = size.width + 20;
        
        toastLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width/2 - width/2, y: vc.view.frame.size.height-100, width: width, height: size.height + 10))
        
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        vc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func getTextContentSize(font : UIFont, textString: String, vc: UIViewController) -> CGSize {
        
        let textAttributes = [NSAttributedStringKey.font: font]
        let rect = textString.boundingRect(with: CGSize(width: vc.view.frame.size.width - 50, height: 2000), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return rect.size
    }
}
