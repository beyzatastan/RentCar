//
//  PersonalInfosViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class PersonalInfosViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fullnameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func updateChangesButton(_ sender: Any) {
    }
}
class PersonalSettingsViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
