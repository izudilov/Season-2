//
//  Token.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 20.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation

final class Session {
    
    static let shared = Session ()
    private init() {}
    
    var acess_token: String?
    var userID: Int?
}
