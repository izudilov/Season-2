//
//  GroupVK.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 23.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import RealmSwift

protocol NewsSource {
   var title: String { get }
   var imageUrl: URL? { get }
}

class GroupVK: Object, Decodable, NewsSource {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo_100: String = ""

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo_100
      }
    
   
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photo_100 = try container.decode(String.self, forKey: .photo_100)
        
    }
    
    var title: String { return "\(name)" }
    var imageUrl: URL? { return URL(string: photo_100) }

}

class GroupsList: Decodable {
    let items: [GroupVK]
    
   enum CodingKeys: String, CodingKey {
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([GroupVK].self, forKey: .items)
       
          }
}
    
class StructAPIGruop: Decodable {
        let response: (GroupsList)
        
        enum CodingKeys: String, CodingKey {
             case response
         }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.response = try container.decode((GroupsList).self, forKey: .response)
           
    }

}

class MyGroupVK {
    
    static var groupsFromVK = [GroupVK]()
    
    
    
}
