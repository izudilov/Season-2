//
//  GetData.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 14.02.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import UIKit
import Alamofire

class GetData: AsyncOperation {

    override func cancel() {
            request.cancel()
            super.cancel()
        }
        
        private var request: DataRequest
        var data: Data?
        
        override func main() {
            request.responseData(queue: DispatchQueue.global()) { [weak self] response in
                self?.data = response.data
                self?.state = .finished
            }
        }
        
        init(request: DataRequest) {
            self.request = request
        }
    
}
