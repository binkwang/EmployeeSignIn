//
//  SignInViewController.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 9/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func signIn(withEmail email: String) {
        Service.shared.signIn(withEmail: email, start: {
            DispatchQueue.main.async {
                SVProgressHUD.show()
            }
        }, success: { [weak self] (user) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                strongSelf.gotoConfirmationPage()
            }
            }, failure: { [weak self] (errorMessage) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    strongSelf.showAlert("error", errorMessage, confirmHandler: nil, cancelHandler: nil)
                }
        })
    }
    
    private func gotoConfirmationPage() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let confirmationViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmationViewController") as? ConfirmationViewController {
            self.navigationController?.pushViewController(confirmationViewController, animated: true)
        }
    }
}
