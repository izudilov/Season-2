//
//  UserVK.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 22.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import RealmSwift


class UserVK: Object, Decodable {
    
    @objc dynamic var first_name: String = ""
    @objc dynamic var last_name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo_100: String = ""
    @objc dynamic var photo_200_orig: String = ""
    
    enum CodingKeys: String, CodingKey {
        case first_name
        case last_name
        case id
        case photo_100
        case photo_200_orig
      }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.id = try container.decode(Int.self, forKey: .id)
        self.first_name = try container.decode(String.self, forKey: .first_name)
        self.last_name = try container.decode(String.self, forKey: .last_name)
        self.photo_100 = try container.decode(String.self, forKey: .photo_100)
        self.photo_200_orig = try container.decode(String.self, forKey: .photo_200_orig)
        
    }
}

class FriendsList: Decodable {
    let items: [UserVK]
    
   enum CodingKeys: String, CodingKey {
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([UserVK].self, forKey: .items)
       
          }
}
    
class StructAPI: Decodable {
        let response: (FriendsList)
        
        enum CodingKeys: String, CodingKey {
             case response
         }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.response = try container.decode((FriendsList).self, forKey: .response)
           
    }

}

class FriendsVK {
    
    static var friends = [UserVK]()
    
    
    
}
