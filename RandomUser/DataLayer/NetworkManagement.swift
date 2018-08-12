//
//  NetworkManagement.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 12/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import Foundation

class NetworkManagement {
    
    var url = URL(string: "https://api.randomuser.me/?results=40")!
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    typealias JSONDictionaryHandler = (([String:AnyObject]?) -> Void)
    
    func downloadJSONFromURL(_completion: @escaping JSONDictionaryHandler) -> Set<User>
    {
        var randomUsers = Set<User>()
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request)
        {(data, response,error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data {
                            do {
                                let callResult = try JSONDecoder().decode(RandomAPIResult.self, from:data)
                                for user in callResult.results {
                                    let user = self.mapDTOInModel(user: user)
                                    randomUsers.insert(user)
                                }
                            } catch let error as NSError {
                                print ("Error processing json data: \(error.description)")
                            }
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
        return randomUsers
    }
    
    func mapDTOInModel(user:RandomAPIUser) -> User {
        let currentUser = User(name: user.name.first, surname: user.name.last,
                               email: user.email, picture: user.picture.medium.absoluteString,
                               phone: user.cell, gender: user.gender,
                               registerDate: user.registered.date,
                               location: Location(street: user.location.street,
                                                  city: user.location.city,
                                                  state: user.location.state))
        return currentUser
    }
}
