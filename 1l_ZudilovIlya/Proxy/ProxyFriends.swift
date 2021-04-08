//
//  ProxyFriends.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 08.04.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation

protocol GetFriendsProxy {

    func loadVKFriends (completion: @escaping ([UserVK]) -> Void )
}

class FriendsProxy: GetFriendsProxy  {
   

    let friends: APIFriends

    init(data: APIFriends) {
        self.friends = data
    }

    func loadVKFriends(completion: @escaping ([UserVK]) -> Void) {
        self.friends.loadVKFriends(completion: completion)
        print("Loading friends from VK")
    }
}
