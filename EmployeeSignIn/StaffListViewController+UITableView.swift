//
//  StaffListViewController+UITableView.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 8/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

extension StaffListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.selectedIndexPath = indexPath
        self.tableView.reloadData()
        self.signInButton.isHidden = false
        self.searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - DataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kStaffCellReuseIdentifier, for: indexPath) as? StaffCell else {
            fatalError("The dequeued cell is not an instance of StaffCell.")
        }
        cell.staff = viewModel.itemAtIndexPath(indexPath: indexPath)
        
        cell.isSelectedStatus = false
        
        if let selectedIndexPath = viewModel.selectedIndexPath {
            if indexPath == selectedIndexPath {
                cell.isSelectedStatus = true
            }
        }
        return cell
    }
}
