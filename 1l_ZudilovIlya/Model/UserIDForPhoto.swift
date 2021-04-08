//
//  UserIDForPhoto.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 17.01.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation
import RealmSwift

class UserIDForPhoto: Object {
    
    @objc dynamic var id: Int = 0
    var photo = List<PhotoVK>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
