//
//  DetailViewController.swift
//  RandomUser
//
//  Created by Ana Rebollo Pin on 12/8/18.
//  Copyright © 2018 Ana Rebollo Pin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var registeredDate: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    var user: User?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFieldsWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func populateFieldsWithData(){
        name.text = user?.name
        surname.text = user?.surname
        gender.text = user?.gender
        street.text = user?.location.street
        city.text = user?.location.city
        state.text = user?.location.state
        registeredDate.text = user?.registerDate
        email.text = user?.email
        let url = URL(string: (user?.picture)!)!
        picture.kf.setImage(with: url)
    }
}
