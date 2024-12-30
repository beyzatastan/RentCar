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
    @IBOutlet weak var soyadText: UITextField!
    
    var viewModel=UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
       
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let firstName = nameText.text, !firstName.isEmpty else {
                showErrorMessage("First name cannot be empty")
                return
            }
            guard let lastName = soyadText.text, !lastName.isEmpty else {
                showErrorMessage("Last name cannot be empty")
                return
            }
            guard let email = emailText.text, !email.isEmpty else {
                showErrorMessage("Email cannot be empty")
                return
            }
            guard let phoneNumber = phoneNumberText.text, !phoneNumber.isEmpty else {
                showErrorMessage("Phone number cannot be empty")
                return
            }
            guard let password = passwordText.text, !password.isEmpty else {
                showErrorMessage("Password cannot be empty")
                return
            }
        let newUser = AddUserModel(firstName: firstName, lastName: lastName, emailAddress: email, phoneNumber: phoneNumber, password: password)

           // Backend'e gönderim için işlemi başlatıyoruz
           viewModel.addUser(user: newUser) { userId in
               if let userId = userId {
                   // İşlem başarılıysa, kullanıcıyı ilgili ekrana yönlendiriyoruz
                   print("User created with ID: \(userId)")
                   
                   // Örneğin, OdemeViewController'e geçiş yapıyoruz
                   let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
                   self.navigationController?.pushViewController(vc, animated: true)
               } else {
                   // Hata durumunda yapılacaklar
                   print("User creation failed.")
               }
           }
       }
    func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        // Create a "Dismiss" action
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        // Add the action to the alert controller
        alertController.addAction(dismissAction)
        
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }

}
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var loginWebService = UserWebServices()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberText.text, !phoneNumber.isEmpty else {
            showAlert(title: "Hata", message: "Telefon numarasını giriniz.")
            return
        }
        
        guard let password = passwordText.text, !password.isEmpty else {
            showAlert(title: "Hata", message: "Şifreyi giriniz.")
            return
        }

  
        loginWebService.loginUser(phoneNumber: phoneNumber, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userId):
                    // Giriş başarılı, kullanıcıyı yönlendir
                    print("Giriş başarılı, User ID: \(userId)")
                    // Kullanıcı ID'sini kaydedebiliriz
                    UserDefaults.standard.set(userId, forKey: "userId")
                    let vc = self.storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    
                case .failure(let error):
                    self.showAlert(title: "Hata", message: "Giriş işlemi başarısız: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
