//
//  UIViewController+.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(_ title: String, _ message: String, confirmHandler: (()->())?, cancelHandler: (()->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            if let cancelHandler = cancelHandler { cancelHandler() }
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            if let confirmHandler = confirmHandler { confirmHandler() }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


