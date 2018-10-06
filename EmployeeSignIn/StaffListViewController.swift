//
//  StaffListViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import SVProgressHUD

class StaffListViewController: UIViewController {
    
    var dataProvider = StaffListDataProvider()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var signInButton: ActionButton!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if let currentStaffList = dataProvider.currentStaffList,
            let selectedIndexPath = dataProvider.selectedIndexPath,
            let fullName = currentStaffList[selectedIndexPath.row].fullName {
            
            self.showAlert("Confirm Signin", "Hi \(fullName), confirm your sign in at 8:30am", confirmHandler: { [weak self] in
                guard let _ = self else { return }
                
                
                }, cancelHandler: { [weak self] in
                    guard let _ = self else { return }
            })
        }        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        
        self.configTableView()
        self.configSearchBar()
        self.signInButton.isHidden = true
        
        
        dataProvider.fetchData(start: {
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        }, complete: { [weak self] in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                weakSelf.tableView.reloadData()
            }
        }) { [weak self] (errMessage) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                weakSelf.showAlert("error", errMessage, confirmHandler: nil, cancelHandler: nil)
            }
        }
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = dataProvider
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = UIColor.gray
        
        let nib = UINib.init(nibName: "StaffCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kStaffCellReuseIdentifier)
    }
    
    func configSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.light
            textFieldInsideSearchBar.textColor = UIColor.black
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showWeatherDetailPage"  {
//            let indexPath: NSIndexPath = self.tableView.indexPath(for: sender as! WeatherTableViewCell)! as NSIndexPath
//            if let destinationViewController = segue.destination as? WeatherDetailViewController {
//                destinationViewController.dayWeather = (self.dataProvider.dayWeather)[indexPath.row]
//                destinationViewController.cityName = self.cityObject?.name
//            }
//        }
    }
}

// MARK: - UITableViewDelegate

extension StaffListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.dataProvider.selectedIndexPath = indexPath
        self.tableView.reloadData()
        self.signInButton.isHidden = false
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UISearchBarDelegate

extension StaffListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.dataProvider.currentStaffList = self.dataProvider.staffList.filter({ staff -> Bool in
            if searchText.isEmpty { return true }
            guard let isContain = staff.fullName?.lowercased().contains(searchText.lowercased()) else { return false }
            return isContain
        })
        self.dataProvider.selectedIndexPath = nil
        self.tableView.reloadData()
    }
}
