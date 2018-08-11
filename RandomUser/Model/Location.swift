//
//  Location.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 10/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import Foundation

struct Location: Hashable {
    
    var street: String
    var city: String
    var state: String
    
    init(street: String, city: String, state: String) {
        self.street = street
        self.city = city
        self.state = state
    }
}
