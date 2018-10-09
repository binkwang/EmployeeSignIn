//
//  ConfirmationViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var signInTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }
    
    private func configUI() {
        if let date = Service.shared.currentUser?.metadata.lastSignInDate {
            signInTimeLabel.text = date.getTime()
            
            if let timeStage = date.getTimeStage() {
                greetingLabel.text = "Good \(timeStage)!"
            }
        }
    }
}
