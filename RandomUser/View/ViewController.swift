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
    var selectedUser: User?
    
    var url = URL(string: "https://api.randomuser.me/?results=40")!
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    typealias JSONDictionaryHandler = (([String:AnyObject]?) -> Void)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSONFromURL(_completion: { (data) in })
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = randomUsers.index(randomUsers.startIndex, offsetBy: indexPath.row)
        selectedUser = randomUsers[position]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        detailVC.user = selectedUser
        navigationController?.pushViewController(detailVC, animated: false)
    }
    
    func mapDTOInModel(user:RandomAPIUser) {
        let currentUser = User(name: user.name.first, surname: user.name.last,
                            email: user.email, picture: user.picture.medium.absoluteString,
                            phone: user.cell, gender: user.gender,
                            registerDate: user.registered.date,
                            location: Location(street: user.location.street,
                                               city: user.location.city,
                                               state: user.location.state))
        
        self.randomUsers.insert(currentUser)
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
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
                                    self.mapDTOInModel(user: user)
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
