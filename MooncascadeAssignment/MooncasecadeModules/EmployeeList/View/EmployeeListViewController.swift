//
//  ViewController.swift
//  MooncascadeAssignment
//
//  Created by webwerks on 04/03/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import UIKit

class EmployeeListViewController: BaseViewController {

    //MARK:- Variable declarations

    let tableView = UITableView.init(frame: .zero, style: .grouped)
    let searchController = UISearchController(searchResultsController: nil)

    let viewModel = EmployeeListViewModel()
    var employeeCategories = [[Employee]]()
    var allEmployees = [Employee]()
    var filteredEmployess = [Employee]()
    
    var isFilterTableLoading = false
    
    let cellIdentifier = "CellEmployees"

    
    //MARK:- View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()

        self.title = "Employees"
        self.showActivityIndicatory(uiView: self.view)
        viewModel.callToGetEmployeeListFromServer { (employees,allEmployees) in
            self.employeeCategories = employees!
            self.allEmployees = allEmployees!
            
            DispatchQueue.main.async {
                self.hideActivityIndicatorView()
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Helpers for UI & setup data
    
    func setupTableView(){
        
        self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 20)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }

    func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
    }

}

//MARK:- TableView datasource & delegate methods

extension EmployeeListViewController : UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isFilterTableLoading {
            return 1
        }
        return employeeCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterTableLoading {
            return filteredEmployess.count
        }
        return employeeCategories[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)

        cell.tintColor = UIColor.customBlue
        
        if isFilterTableLoading {
            
            let employee = filteredEmployess[indexPath.row]
            
            cell.textLabel?.text = "\(employee.first_name) \(employee.last_name)"
            cell.detailTextLabel?.text = employee.contactDetails?.phone

            
        }else{
            
            let employees = employeeCategories[indexPath.section]
            let employee = employees[indexPath.row]
            
            cell.textLabel?.text = "\(employee.first_name) \(employee.last_name)"
            cell.detailTextLabel?.text = employee.contactDetails?.phone
            
            if employee.isContactAvilable{
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isFilterTableLoading {
            return nil
        }else{
            let employees = employeeCategories[section]
            let indexPath = IndexPath(item: 0, section: section)
            let employee = employees[indexPath.row]
            return employee.position
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let employees = employeeCategories[indexPath.section]
        let employee = employees[indexPath.row]

        let employeeDetailViewController:EmployeeDetailViewController = EmployeeDetailViewController() as EmployeeDetailViewController
        employeeDetailViewController.employee = employee
        self.navigationController?.pushViewController(employeeDetailViewController, animated: true)
    }
}
extension EmployeeListViewController : UISearchResultsUpdating,UISearchBarDelegate{
    
    @objc func hideKeyboard(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count) <= 0 {
            perform(#selector(self.hideKeyboard), with: searchBar, afterDelay: 0.2)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFilterTableLoading = false
        filteredEmployess = self.allEmployees
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isFilterTableLoading = true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isFilterTableLoading = true
        return true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {

            let filteredEmployeeByFirstname = self.allEmployees.filter{$0.first_name.lowercased().contains(searchText.lowercased())}
            
            let filteredEmployessByLastname = self.allEmployees.filter{$0.last_name.lowercased().contains(searchText.lowercased())}
            
            let filteredEmployessByEmail = self.allEmployees.filter{($0.contactDetails?.email.lowercased().contains(searchText.lowercased()))!}
        
            let filteredEmployessByPosition = self.allEmployees.filter{$0.position.lowercased().contains(searchText.lowercased())}
            
            filteredEmployess.insert(contentsOf: filteredEmployeeByFirstname, at: 0)
            filteredEmployess.insert(contentsOf: filteredEmployessByLastname, at: 0)
            filteredEmployess.insert(contentsOf: filteredEmployessByEmail, at: 0)
            filteredEmployess.insert(contentsOf: filteredEmployessByPosition, at: 0)
            
            if self.filteredEmployess.count <= 0 {
                filteredEmployess = [Employee]()
            }
            
        } else {
            filteredEmployess = self.allEmployees
        }
        tableView.reloadData()
    }
}
