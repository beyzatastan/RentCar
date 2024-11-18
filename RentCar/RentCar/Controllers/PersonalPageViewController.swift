//
//  PersonalPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class PersonalPageViewController: UIViewController {
    
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonView: UIView!
    let array = ["Hesap Bilgileri","Geçmiş Kiralamalar","Araç Bilgileri","Ödeme Bilgileri","Kullanıcı Ayarları","Yardım ve Destek","Geri Bildirim ve Şikayer","Uygulama Bilgileri"]
    
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
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
}

extension PersonalPageViewController: UITableViewDataSource,UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
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
               let vc1 = storyboard?.instantiateViewController(withIdentifier: "personalInfos") as! PersonalInfosViewController
               navigationController?.pushViewController(vc1, animated: true)
           case 1:
               let vc2=storyboard?.instantiateViewController(identifier: "lastRides") as! LastRidesViewController
               navigationController?.pushViewController(vc2, animated: true)
           case 2:
               let vc4=storyboard?.instantiateViewController(identifier: "carInfos") as! CarInfosViewController
               navigationController?.pushViewController(vc4, animated: true)
           case 3:
               let vc3=storyboard?.instantiateViewController(identifier: "payment") as! PaymentViewController
               navigationController?.pushViewController(vc3, animated: true)
           case 4:
               let vc5=storyboard?.instantiateViewController(identifier: "personalSettings") as! PersonalSettingsViewController
               navigationController?.pushViewController(vc5, animated: true)
           case 5:
               let vc6=storyboard?.instantiateViewController(identifier: "support") as! SupportPageViewController
               navigationController?.pushViewController(vc6, animated: true)
           case 6:
               let vc7=storyboard?.instantiateViewController(identifier: "appInfos") as! ApplicationInfosViewController
               navigationController?.pushViewController(vc7, animated: true)
           default:
               break
           }
        
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    
}
