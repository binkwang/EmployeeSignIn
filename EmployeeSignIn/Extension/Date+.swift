//
//  Date+.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 9/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

extension Date {
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func getTimeStage() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: self)
        
        var timeStage: String?
        
        if time.components(separatedBy: ":").count == 2 {
            if let hourString = time.components(separatedBy: ":").first, let hour = Int(hourString) {
                if hour >= 0 && hour < 12 { timeStage = "morning" }
                else if hour >= 12 && hour <= 18 { timeStage = "afternoon" }
                else { timeStage = "evening" }
            }
        }
        return timeStage
    }
}
