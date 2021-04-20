//
//  Group.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 01.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

class MyGroups {
    
    var name: String
    var logo: String
 
    init(name: String, logo: String) {

        self.name = name
        self.logo = logo
        
    }

    static var myGroupData: [MyGroups] = [
        MyGroups(name: "Жители океана и не только", logo: "1.jpg"),
        MyGroups(name: "Красти Крабс - forever", logo: "2.jpg"),
        MyGroups(name: "Любители ловивить медузы сочком", logo: "3.jpg")
    ]
    

}


class NoMyGroups {
    
    var name: String
    var logo: String
 
    init(name: String, logo: String) {

        self.name = name
        self.logo = logo
        
    }

    static var noMyGroupData: [NoMyGroups] = [
        NoMyGroups(name: "Планктон - Властелин мира!", logo: "4.jpg"),
        NoMyGroups(name: "Сокровища морского ущелья", logo: "6.jpeg"),
        NoMyGroups(name: "Эволяция губок - будущее океана", logo: "5.jpg")
    ]
    
}
