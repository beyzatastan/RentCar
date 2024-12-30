//
//  PersonalPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class PersonalPageViewController: UIViewController {
    
    @IBOutlet weak var cıkısYapButton: UIButton!
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonView: UIView!
    let array = ["Kullanıcı Bilgileri","Geçmiş Kiralamalar","Ödeme Bilgileri","Kullanıcı İzinleri"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.sendSubviewToBack(view1)
        view.bringSubviewToFront(buttonView)
        view.bringSubviewToFront(personView)
        view1.layer.cornerRadius = 10
        personView.layer.cornerRadius = 10
        buttonView.layer.cornerRadius = 10
        tableView.delegate=self
        tableView.dataSource=self
        
        if let customerId = UserDefaults.standard.value(forKey: "customerId") as? Int {
              // Eğer customerId varsa, "Çıkış Yap" yazsın
              cıkısYapButton.setTitle("Mevcut Kullanıcı Bilgilerimi Sıfırla ", for: .normal)
          } else {
              // Eğer customerId yoksa, "Giriş Yap" yazsın
              cıkısYapButton.isHidden=true
          }
    }
    @IBAction func cikisYapButtonClicked(_ sender: Any) {
        
            if let customerId = UserDefaults.standard.value(forKey: "customerId") as? Int {
                // Eğer customerId varsa, çıkış yap
                UserDefaults.standard.removeObject(forKey: "customerId")
                
                makeAlert(title: "Başarılı", message: "Kullanıcı başarıyla sıfırlandı.")

            }
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func rentButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
}

extension PersonalPageViewController: UITableViewDataSource,UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.font = UIFont(name: "GillSans", size: 20) 
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           switch indexPath.row {
           case 0:
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase = "4"
               navigationController?.pushViewController(vc, animated: true)
           case 1:
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase = "5"
               navigationController?.pushViewController(vc, animated: true)
           case 2:
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase = "6"
               navigationController?.pushViewController(vc, animated: true)
           case 3:
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase = "7"
               navigationController?.pushViewController(vc, animated: true)
           default:
               break
           }
        
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Tamam", style: .cancel) { _ in
            // OK butonuna basıldığında ana sayfaya yönlendiriyoruz
            if let viewController = self.storyboard?.instantiateViewController(identifier: "main") as? MainPageViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
