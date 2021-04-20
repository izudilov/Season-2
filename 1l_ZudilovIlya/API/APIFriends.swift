//
//  APIFriends.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 20.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class APIFriends {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.126"

    
    func loadVKFriends (completion: @escaping ([UserVK]) -> Void ){
        
               
        let request = "friends.get"
        
        guard let user = Session.shared.userID else {return}
        guard let apiKey = Session.shared.acess_token else {return}
        
        let parameters: Parameters = [
            "user_ids": user,
            "fields": "photo_100, photo_200_orig",
            "access_token": apiKey,
            "v": version
        ]
        
        let url = baseUrl+request
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
                       
            guard let data = response.data else { return }
            
            do {
                let parsedResult: StructAPI = try JSONDecoder().decode(StructAPI.self, from: data)
                let array = parsedResult.response.items
                FriendsVK.friendsModel = array
                print(array[0].first_name)
                
                do {
                    let realm =  try Realm()
                    print(realm.configuration.fileURL)
                    realm.beginWrite()
                    realm.add(parsedResult.response.items, update: .all)
                    try realm.commitWrite()
                    
                } catch {
                    print(error)
                }
                
                completion (array)
                
            }
            catch {
                print(error)
            }
           
            
           /* switch response.result {
               
                        case .success:
                                    do {
                                        let parsedResult: StructAPI = try JSONDecoder().decode(StructAPI.self, from: response.data!)
                                        let array = parsedResult.response.items
                                        FriendsVK.friends = array
                                        
                                        return
                                        }
                                    catch {
                                        print(error)
                                    }
                            
                        case .failure(let error):
                                print(error)
            
           
                    }*/
        
        }
        
    }
}
