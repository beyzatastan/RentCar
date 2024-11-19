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
               let vc=storyboard?.instantiateViewController(identifier: "uyelik") as! InfosViewController
               navigationController?.pushViewController(vc, animated: true)
           default:
               break
           }
        
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    
}
