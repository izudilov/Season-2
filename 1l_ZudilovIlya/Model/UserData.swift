//
//  UserData.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 16.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation

final class UserData {
    
    static let shared = UserData ()
    private init() {}
    
    var userId: Int?
    var token: String?
    var userName: String?
    
}
