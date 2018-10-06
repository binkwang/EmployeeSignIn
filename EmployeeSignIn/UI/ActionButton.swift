//
//  ActionButton.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 25
        layer.masksToBounds = true
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 3, height: 3)
        
        setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
}
