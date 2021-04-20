//
//  APIPhotos.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 20.12.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import Foundation
import Alamofire

class APIPhotos {
    
    let baseUrl = "https://api.vk.com/method/"
    let version = "5.126"
    
    func loadVKPhotos(completion: @escaping ([PhotoSize]) -> Void ) {
        
        let request = "photos.getAll"
        
        guard let user = Session.shared.userID else {return}
        guard let apiKey = Session.shared.acess_token else {return}
        
        let parameters: Parameters = [
            "owner_id": user,
            "extended": 0,
            "offset": 0,
            "photo_sizes": 0,
            "no_service_albums": 0,
            "need_hidden" : 0,
            "skip_hidden": 1,
            "count": "100",
            "access_token": apiKey,
            "v": version,
            
        ]
        
        let url = baseUrl+request
        
        AF.request(url, method: .get, parameters:
                    parameters).responseJSON { response in
 
                        //guard let data = response.data else { return }

                        do {
                            let parsedResult: StructAPIPhoto = try JSONDecoder().decode(StructAPIPhoto.self, from: response.data!)
                            
                            let array = parsedResult.response.items
                            
                            AllPhotosVK.photosFromVK = array
                            completion (array)
                            
                        }
                        catch {
                            print(error)
                        }
                       
                    }
    }
}

