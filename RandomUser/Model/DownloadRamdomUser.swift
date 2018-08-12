//
//  DownloadRamdomUser.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 12/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import Foundation

class DownloadRamdomUser {
    
    func downloadUsers() -> Set<User> {
        var randomUsers = Set<User>()
        let networkManager = NetworkManagement()
        randomUsers = networkManager.downloadJSONFromURL(_completion: { (data) in })
        return randomUsers
    }
}
