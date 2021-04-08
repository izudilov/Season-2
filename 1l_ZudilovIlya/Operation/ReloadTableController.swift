//
//  ReloadTableController.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 14.02.2021.
//  Copyright © 2021 izudilov. All rights reserved.
//

import UIKit

class ReloadTableController: Operation {
    
    var controller: NewsTableViewController
     
     init(controller: NewsTableViewController) {
         self.controller = controller
     }
     
     override func main() {
         guard let parseData = dependencies.first as? APINews else { return }
         controller.newsVK = parseData.outputData
         controller.tableView.reloadData()
   
   }

}
