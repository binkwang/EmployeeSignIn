//
//  Staff.swift
//  EmployeeSignIn
//
//  Created by Bink Wang on 4/10/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct Staff {
    var id: String!
    var fullName: String!
    var avatar: String?
}

extension Staff: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "fullName"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let fullName: String = try container.decode(String.self, forKey: .fullName)
        let avatar: String = try container.decode(String.self, forKey: .avatar)

        self.init(id: id, fullName: fullName, avatar: avatar)
    }
}
