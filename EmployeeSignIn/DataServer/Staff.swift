//
//  Staff.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct Staff {
    var uid: String!
    var email: String!
    var displayName: String!
    var photoURL: String?
}

extension Staff: Decodable {
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case email = "email"
        case displayName = "displayName"
        case photoURL = "photoURL"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let uid: String = try container.decode(String.self, forKey: .uid)
        let email: String = try container.decode(String.self, forKey: .email)
        let displayName: String = try container.decode(String.self, forKey: .displayName)
        let photoURL: String = try container.decode(String.self, forKey: .photoURL)

        self.init(uid: uid, email: email, displayName: displayName, photoURL: photoURL)
    }
}
