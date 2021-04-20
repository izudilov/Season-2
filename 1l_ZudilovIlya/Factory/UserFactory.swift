//
//  UserFactory.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 17.04.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation

final class UserFactory {

    func constructViewModels(from groups: [UserVK]) -> [UserModel] {
        
        return groups.compactMap{self.getViewModel(from: $0)}
    }

    private func getViewModel(from user: UserVK) -> UserModel {

        let userPhoto = user.photo_100
        let userFirstName = user.first_name
        let userLastName = user.last_name
        let userFullName = user.last_name + " " + user.first_name
        let userID = user.id


        return UserModel(userID: userID, userFirstName: userFirstName, userLastName: userLastName, userFullName: userFullName, userPhoto: userPhoto)
    }
}
