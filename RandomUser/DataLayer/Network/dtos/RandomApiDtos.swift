//
//  RandomApiDtos.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 11/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import Foundation

struct RandomAPIUser: Decodable {
   // let id: RandomAPIId
    let gender: String
    let name: RandomAPIUserName
    let location: RandomAPILocation
    let email: String
    let picture: RandomAPIUserPicture
    let phone: String
    let cell: String
    let registered: RamdomAPIRegisteredDate
}

struct RandomAPIId: Decodable {
    let name: String
    let value: String
}

struct RandomAPIUserPicture: Decodable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}

struct RandomAPIUserName: Decodable {
    let title: String
    let first: String
    let last: String
}

struct RandomAPILocation: Decodable {
    let street: String
    let city: String
    let state: String
}

struct RandomAPICoordinates: Decodable {
    let latitude: Double
    let longitude: Double
}

struct RandomAPIResult: Decodable {
    let results: [RandomAPIUser]
}

struct RamdomAPIRegisteredDate: Decodable {
    let date: String
    let age: Int
}
