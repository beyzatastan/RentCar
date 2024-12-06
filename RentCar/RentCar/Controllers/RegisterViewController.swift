//
//  RegisterViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class RegisterViewController: UIViewController {
   
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButton(_ sender: Any) {
    }
    
}
class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
}

class VerifyViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
