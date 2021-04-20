//
//  APINews.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 06.02.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import Foundation
import Alamofire


class APINews: Operation {
    
    var outputData: Response?
    
    static var id = [Int]()
    
        override func main() {
    

        guard let getDataOperation = dependencies.first as? GetData,
        let data = getDataOperation.data else { return }

        
        do {
            let decoder = JSONDecoder()                       
            let parsedResult: Welcome = try JSONDecoder().decode(Welcome.self, from: data)
            let array = parsedResult.response
            self.outputData = array
            
            var i = 0
            var arrayIDGroup = [Int]()
            var arrayIDUser = [Int]()
            
            while i < array.items.count ?? 0 {
                if array.items[i].source_id < 0 {
                    
                    arrayIDGroup.append((array.items[i].source_id) * -1)
                } else {
                    arrayIDUser.append(array.items[i].source_id)
                }
                i += 1
            }
            
            APINews.id = arrayIDGroup
            print(APINews.id.count)

        }
        catch {
            print(error)
        }
}

        }

