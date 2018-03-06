//
//  BaseViewController.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 06/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createdRoundedButton(btn:UIButton){
        btn.layer.cornerRadius = btn.frame.size.width/2
        btn.clipsToBounds = true
    }
    
    func showActivityIndicatory(uiView: UIView) {
        activityIndicator.frame = CGRect.init(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.gray
        uiView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicatorView(){
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
