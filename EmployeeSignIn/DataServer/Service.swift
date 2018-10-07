//
//  Service.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import Firebase

class Service {
    
    // MARK: - Properties
    
    var ref: DatabaseReference!
    
    // MARK: - Initializers
    
    /// Returns a shared instance of TMEService.
    public static let shared = Service()
    
    private init() {
        FirebaseApp.configure()
        ref = Database.database().reference()
    }
    
    // MARK: -
    
    /// Request Users
    ///
    /// Return user instances.
    ///
    /// - parameter start: The callback called when remote data request start.
    /// - parameter gotInstance: The callback called when one user instance got parsed.
    /// - parameter complete: The callback called when all the instance parsed.
    /// - parameter failure: The callback called when an error happens.
    func fetchUsers(start: @escaping () -> Void,
                    gotInstance: @escaping (_ staff: Staff) -> Void,
                    complete: @escaping () -> Void,
                    failure: @escaping (_ errMessage: String) -> Void) {        
        start()
        let usersRef = Service.shared.ref.child("users")
        usersRef.observe(.value, with: { snapshot in
            if let snapshotValue = snapshot.value as? NSArray {
                snapshotValue.forEach({ (staff) in
                    if let staff = staff as? NSDictionary, let id = staff["id"] as? String, let fullName = staff["fullName"] as? String {
                        let avatar = staff["avatar"] as? String
                        let staff = Staff(id: id, fullName: fullName, avatar: avatar)
                        gotInstance(staff)
                    } else {
                        failure("Data formate error")
                    }
                })
                complete()
            } else {
                failure("Data formate error")
            }
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
}
