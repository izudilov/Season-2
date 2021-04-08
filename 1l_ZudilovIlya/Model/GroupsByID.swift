//
//  GroupsByID.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 04.03.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct WelcomeID: Decodable {
    var response: [GroupsIDFromVK]
    
    enum CodingKeys: String, CodingKey {
         case response
     }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode([GroupsIDFromVK].self, forKey: .response)
           
    }
}

// MARK: - GroupsIDFromVK

struct GroupsIDFromVK: Decodable {
    var name: String = ""
    var photo_50: String = ""

    enum CodingKeys: String, CodingKey {
        case name
        case photo_50
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.photo_50 = try container.decode(String.self, forKey: .photo_50)
    }
}
