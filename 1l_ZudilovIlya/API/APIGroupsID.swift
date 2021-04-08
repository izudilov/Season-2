//
//  APIGroupsID.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 04.03.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation
import Alamofire



/*class AfID: Operation {
    
    var outputData = [GroupsIDFromVK]()
    
    override func main() {
        
        let baseUrl = "https://api.vk.com/method/"
        let version = "5.126"
        let user = Session.shared.userID!
        let apiKey = Session.shared.acess_token!
        let request3 = "groups.getById"
        
        let url2 = baseUrl + request3
        
        let parameters2: Parameters = [
            "group_ids": APINews.id,
            "access_token": apiKey,
            "v": version
        ]
        
        let request2 =  AF.request(url2, method: .get, parameters: parameters2).responseJSON {  response in
                                        
            guard let data = response.data else { return }
            print(response.request)
            
            
            do {
                let parsedResult: WelcomeID = try JSONDecoder().decode(WelcomeID.self, from: data)
                let array = parsedResult.response
                print(array.first)
                self.outputData = array
                NewsTableViewController.groupsID = array
                                
            }
            catch {
                print(error)
            }
            
           
        }
    }
    
}*/

class APIGroupID: Operation {
    
    var outputData: [GroupsIDFromVK]?
    
    override func main() {
        print("11111111111111111111111111")
        guard let getDataOperation = dependencies.first as? GetData,
        let data = getDataOperation.data else { return }
    
        do {
            let parsedResult: WelcomeID = try JSONDecoder().decode(WelcomeID.self, from: data)
            let array = parsedResult.response
            self.outputData = array
            NewsTableViewController.groupsID = array
                            
        }
        catch {
            print(error)
        }
    }
}

