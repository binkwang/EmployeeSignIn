//
//  StaffListViewModel.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import UIKit

class StaffListViewModel: NSObject {
    
    // MARK: - Properties
    
    var staffList = [Staff]()
    var currentStaffList: [Staff]?
    var selectedIndexPath: IndexPath?
    
    
    // MARK: - Properties for signin alert view
    
    var signinConfirmationMessage: String? {
        if let currentStaffList = self.currentStaffList,
            let selectedIndexPath = self.selectedIndexPath,
            let fullName = currentStaffList[selectedIndexPath.row].fullName {
            return "Hi \(fullName), confirm your sign in at 8:30am." as String
        }
        return nil
    }
    
    
    // MARK: - Functions
    
    func numberOfItemsInSection(section: Int) -> Int {
        return currentStaffList?.count ?? 0
    }
    
    func itemAtIndexPath(indexPath: IndexPath) -> Staff? {
        return currentStaffList?[indexPath.row]
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

