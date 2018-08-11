//
//  ViewController.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 10/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     var randomUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provisionalDummyUser()
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
        cell.textLabel?.text  = randomUsers[indexPath.row].name
        
        return cell
    }
    
    //To-Do: Change for the api call
    func provisionalDummyUser() {
        
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
    }
}

