//
//  ViewController.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 10/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var randomUsers = Set<User>()
    
    var url = URL(string: "https://api.randomuser.me/?results=40")!
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    typealias JSONDictionaryHandler = (([String:AnyObject]?) -> Void)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSONFromURL(_completion: { (data) in })
        //provisionalDummyUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return randomUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomUICell
        let position = randomUsers.index(randomUsers.startIndex, offsetBy: indexPath.row)
        cell.printCell(user: randomUsers[position])
        return cell
    }
    
    //To-Do: Change for the api call
    /*func provisionalDummyUser() {
        
        let calendar = Calendar.current
        
        var components = DateComponents()
        
        components.day = 25
        components.month = 1
        components.year = 2011
        components.hour = 2
        components.minute = 15
        
        let newDate = calendar.date(from: components)
        
        let location = Location.init(street: "Diputacio", city: "Barcelona", state: "Spain")
        let user1 = User.init(name: "Ana",
                      surname: "Rebollo",
                      email: "ana.rebollo.pin@gmail.com",
                      picture: "hola",
                      phone: "675443322",
                      gender: "female" ,
                      registerDate: newDate,
                      location: location)
        let user2 = User.init(name: "Jaime",
                         surname: "Rebollo",
                         email: "jaime.rebollo.pin@gmail.com",
                         picture: "hola",
                         phone: "675443322",
                         gender: "female",
                         registerDate: newDate,
                         location: location)
        let user3 = User.init(name: "Paco",
                         surname: "Sanchez",
                         email: "paco.sanchez@gmail.com",
                         picture: "hola",
                         phone: "675443322",
                         gender: "female" ,
                         registerDate: newDate,
                         location: location)
        randomUsers.append(user1)
        randomUsers.append(user2)
        randomUsers.append(user3)
    }*/
    
    func downloadJSONFromURL(_completion: @escaping JSONDictionaryHandler)
    {
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
                                    let currentUser = User(name: user.name.first, surname: user.name.last, email: user.email, picture: user.picture.thumbnail.absoluteString, phone: user.cell, gender: user.gender, registerDate: user.registered.date, location: Location(street: user.location.street, city: user.location.city, state: user.location.state))
                                   
                                    self.randomUsers.insert(currentUser)
                                    DispatchQueue.main.async { [unowned self] in
                                        self.tableView.reloadData()
                                        print(user)
                                    }
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
    }
}
