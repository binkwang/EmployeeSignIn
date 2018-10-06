//
//  UIColor+.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 5/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    
    static var random: UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    static var light: UIColor {
        return UIColor(red:0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }
    
}
