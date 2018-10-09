//
//  Service.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

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
        let usersRef = Service.shared.ref.child("staff")
        usersRef.observe(.value, with: { snapshot in
            if let snapshotValue = snapshot.value as? NSArray {
                snapshotValue.forEach({ (staff) in
                    if let staff = staff as? NSDictionary,
                        let uid = staff["uid"] as? String,
                        let email = staff["email"] as? String,
                        let displayName = staff["displayName"] as? String {
                        
                        let photoURL = staff["photoURL"] as? String
                        let staff = Staff(uid: uid, email: email, displayName: displayName, photoURL: photoURL)
                        
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
    
    
    /// signIn
    ///
    /// Return user instances or error.
    ///
    /// - parameter start: The callback called when request start.
    /// - parameter success: The callback called when signIn success.
    /// - parameter failure: The callback called when signIn failed.
    func signIn(withEmail email: String,
                start: @escaping () -> Void,
                success: @escaping (_ user: User) -> Void,
                failure: @escaping (_ errMessage: String) -> Void) {
        start()
        Auth.auth().signIn(withEmail: email, password: "123456", completion: { (authResult, error) in
            if let error = error {
                failure(error.localizedDescription)
            } else if let user: User = authResult?.user {
                success(user)
                
//                print("data.email: \(user.email)")
//                print("data.photoURL: \(user.photoURL)")
//                print("data.displayName: \(user.displayName)")
//                print("data.uid: \(user.uid)")
                
            } else {
                failure("unknow error")
            }
            
        })
    }
        
        
    
    
}
