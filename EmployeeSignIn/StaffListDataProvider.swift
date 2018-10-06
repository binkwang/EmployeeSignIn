//
//  StaffListDataProvider.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import UIKit

class StaffListDataProvider: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var staffList = [Staff]()
    var currentStaffList: [Staff]?
    var selectedIndexPath: IndexPath?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - DataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStaffList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kStaffCellReuseIdentifier, for: indexPath) as? StaffCell else {
            fatalError("The dequeued cell is not an instance of StaffCell.")
        }
        cell.staff = self.currentStaffList?[indexPath.row]
        
        cell.isSelectedStatus = false
        
        if let selectedIndexPath = selectedIndexPath {
            if indexPath == selectedIndexPath {
                cell.isSelectedStatus = true
            }
        }        
        return cell
    }
    
    // MARK: - fetchData
    
    func fetchData(start: @escaping () -> Void,
                   complete: @escaping () -> Void,
                   failure: @escaping (_ errMessage: String) -> Void) {        
        Service.shared.fetchUsers(start: {
            start()
        }, gotInstance: { [weak self] (staff) in
            guard let weakSelf = self else { return }
            weakSelf.staffList.append(staff)
            }, complete: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.currentStaffList = weakSelf.staffList
                complete()
        }) { (errString) in
            failure(errString)
        }
    }
}

