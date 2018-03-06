//
//  EmployeeDetailViewController.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 05/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit
import Contacts

class EmployeeDetailViewController: BaseViewController {
    
    //MARK:- Variable declarations
    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let btnBottom = UIButton.init(frame: .zero)

    var employee : Employee? = nil
    var contact = CNContact()
    
    var viewModel = EmployeeDetailViewModel()
    
    let cellIdentifier = "CellEmployeeDetail"
    
    static let BOTTOM_PADDING = 100

    var sections : [Section] = [
        
        Section(type: .EmployeeDetails),
        Section(type: .EmployeeProjects)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        
        viewModel.employeeDetails(employee: employee!)
        self.setupTableView()
        
        if (employee?.isContactAvilable)! {
            self.contact = (employee?.contact)!
            self.setupBottomButton()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Helpers for UI & setup data
    func setupTableView(){
        
        if (employee?.isContactAvilable)! {
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (Constant.BOTTOM_SPACE_NAV_HEIGHT + 50.0))
        }else{
            self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - Constant.BOTTOM_SPACE_NAV_HEIGHT)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }

    func setupBottomButton(){
        
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height - (Constant.BOTTOM_SPACE_NAV_HEIGHT + 50.0), width: self.view.frame.size.width, height: 50))
        bottomView.backgroundColor = UIColor.customWhiteGray
        btnBottom.frame = CGRect.init(x: bottomView.frame.size.width/2 - 20, y: 0, width: 50, height: 50)
        btnBottom.setTitle("Call", for: .normal)
        btnBottom.setImage(UIImage(named: "call_btn_icon"), for: .normal)
        btnBottom.backgroundColor = UIColor.customBlue
        self.createdRoundedButton(btn: btnBottom)
        btnBottom.contentMode = UIViewContentMode.center
        btnBottom.setTitleColor(UIColor.customBlue, for: .normal)
     
        btnBottom.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)

        bottomView.bringSubview(toFront: btnBottom)
        bottomView.addSubview(btnBottom)
        self.view.addSubview(bottomView)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        if let phone = employee?.contactDetails?.phone {
            let trimmedPhoneStr = phone.removingWhitespaces()
            UIApplication.shared.open(NSURL(string: "tel://"+"\(trimmedPhoneStr)")! as URL, options: [:], completionHandler: nil)
        }
    }
    
}

//MARK:- TableView datasource & delegate methods

extension EmployeeDetailViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch sections[section].type {
        case .EmployeeDetails:
            return viewModel.employeeDetail.count
        case .EmployeeProjects:
            if let projects = employee?.projects{
                return projects.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        switch sections[indexPath.section].type {
        case .EmployeeDetails:
            cell.textLabel?.text = viewModel.employeeDetail[indexPath.row]
        case .EmployeeProjects:
            cell.textLabel?.text = employee?.projects![indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section].type {
        case .EmployeeDetails:
            return "Employee Details"
        case .EmployeeProjects:
            return "Employee Projects"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

