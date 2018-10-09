//
//  BaseViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 9/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = Theme.tint
        navigationController?.navigationBar.barTintColor = Theme.background
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
