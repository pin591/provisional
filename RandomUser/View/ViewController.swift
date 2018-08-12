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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var domainCall = DownloadRamdomUser()
        self.randomUsers = domainCall.downloadUsers()
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
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
}
