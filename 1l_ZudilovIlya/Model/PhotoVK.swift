//
//  PhotoVK.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 27.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoVK: Object, Decodable {
    
    @objc dynamic var url: String = ""
    var id = LinkingObjects(fromType: UserIDForPhoto.self, property: "photo")
    
    enum CodingKeys: String, CodingKey {
        case url
      }
    
    override static func primaryKey() -> String? {
        return "url"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.url = try container.decode(String.self, forKey: .url)
       
        
    }
}

class PhotoSize: Decodable {
   let sizes: [PhotoVK]
    
   enum CodingKeys: String, CodingKey {
        case sizes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sizes = try container.decode([PhotoVK].self, forKey: .sizes)
       
          }
}
    
class PhotoList: Decodable {
    let items: [PhotoSize]
    
   enum CodingKeys: String, CodingKey {
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.items = try container.decode([PhotoSize].self, forKey: .items)
       
          }
}
    
class StructAPIPhoto: Decodable {
        let response: (PhotoList)
        
        enum CodingKeys: String, CodingKey {
             case response
         }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.response = try container.decode((PhotoList).self, forKey: .response)
           
    }

}

class AllPhotosVK {
    
    static var photosFromVK = [PhotoSize]()
    
    
    
}
