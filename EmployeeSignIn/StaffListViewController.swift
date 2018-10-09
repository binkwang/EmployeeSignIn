//
//  StaffListViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import SVProgressHUD

class StaffListViewController: BaseViewController {
    
    var viewModel = StaffListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var signInButton: ActionButton!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if let message = viewModel.signinConfirmationMessage {
            self.showAlert("Confirm Signin", message, confirmHandler: { [weak self] in
                guard let weakSelf = self, let email = weakSelf.viewModel.selectedStaff?.email else { return }
                weakSelf.signIn(withEmail: email)
                }, cancelHandler: { [weak self] in
                    guard let _ = self else { return }
                    // TODO:
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        
        self.configTableView()
        self.configSearchBar()
        self.signInButton.isHidden = true
        
        self.fetchStaffData()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = UIColor.gray
        
        let nib = UINib.init(nibName: "StaffCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kStaffCellReuseIdentifier)
    }
    
    private func configSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor.light
            textFieldInsideSearchBar.textColor = UIColor.black
        }
    }
    
    private func fetchStaffData() {
        viewModel.fetchData(start: {
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
}


// MARK: - UISearchBarDelegate

extension StaffListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.currentStaffList = self.viewModel.staffList.filter({ staff -> Bool in
            if searchText.isEmpty { return true }
            guard let isContain = staff.displayName?.lowercased().contains(searchText.lowercased()) else { return false }
            return isContain
        })
        self.viewModel.selectedIndexPath = nil
        self.tableView.reloadData()
    }
}
