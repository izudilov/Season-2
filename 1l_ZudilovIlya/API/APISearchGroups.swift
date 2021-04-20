//
//  APISearchGroups.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 20.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import Alamofire

class APISearchGroups {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.126"
    func getData(searchText: String) {
        let request = "groups.search"
        guard let apiKey = Session.shared.acess_token else {return}
        let parameters: Parameters = [
            "q": searchText,
            "type": "group",
            "sort": 0,
            "access_token": apiKey,
            "v": version
        ]
          
        let url = baseUrl+request
        AF.request(url, method: .get, parameters:
                    parameters).responseJSON { repsonse in
                        print(repsonse.value!)
                    }
    }
}
