//
//  User.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 10/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var surname: String
    var email: String
    var picture: String
    var phone: String
    var gender: String
    var registerDate:NSData
    var location: Location
    
    init (name: String, surname: String, email: String, picture: String, phone: String,
          gender:String, registerDate: NSData, location: Location) {
        self.name = name
        self.surname = surname
        self.email = email
        self.picture = picture
        self.phone = phone
        self.gender = gender
        self.registerDate = registerDate
        self.location = location
    }
}
