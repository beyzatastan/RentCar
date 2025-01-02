//
//  SettingsViewController.swift
//  RentCar
//
//  Created by beyza nur on 19.11.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var girisYapButton: UIButton!
    
    
    let array = ["Hakkımızda","İletişim","Kullanım Koşulları","Uygulama Bilgileri"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton=true
        
        buttonView.layer.cornerRadius = 10
        upView.layer.cornerRadius=10
        buttonView.clipsToBounds=true
        upView.clipsToBounds=true
        
        view.sendSubviewToBack(mainView)
        tableView.delegate=self
        tableView.dataSource=self
        
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int {
              // Eğer customerId varsa, "Çıkış Yap" yazsın
              girisYapButton.setTitle("Mevcut Hesaptan Çıkış Yap➤", for: .normal)
          } else {
              // Eğer customerId yoksa, "Giriş Yap" yazsın
              girisYapButton.setTitle("Mevcut Hesaba Giriş Yap➤", for: .normal)
          }
        
    }
    
    @IBAction func girisYapButtonClicked(_ sender: Any) {
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int {
            UserDefaults.standard.removeObject(forKey: "userId")
            UserDefaults.standard.removeObject(forKey: "customerId")
            let vc=storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc=storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func homeButton(_ sender: Any) {
        let home=storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        navigationController?.pushViewController(home, animated: false)
    }
    @IBAction func rentButton(_ sender: Any) {
        let rentVc=storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
        navigationController?.pushViewController(rentVc, animated: false)
    }
    @IBAction func personButton(_ sender: Any) {
        let personVc=storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        navigationController?.pushViewController(personVc, animated: false)
    }
}
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
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
               vc.selectedCase="0"
               navigationController?.pushViewController(vc, animated: true)
           case 1 :
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase="1"
               navigationController?.pushViewController(vc, animated: true)
           case 2 :
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase="2"
               navigationController?.pushViewController(vc, animated: true)
           case 3 :
               let vc=storyboard?.instantiateViewController(identifier: "infos") as! InfosViewController
               vc.selectedCase="3"
               navigationController?.pushViewController(vc, animated: true)
           default:
               break
           }
        
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
   
}
