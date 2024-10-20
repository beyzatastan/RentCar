//
//  LastRidesViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class LastRidesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    let names = ["bmw 3.20 i","dodge charger","toyota corolla","mercedes c180"]
    let photos = ["bmw","dodge","corolla","mercedes"]
  
 
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lastRidesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastRidesView.layer.cornerRadius = 10
        tableView.delegate=self
        tableView.dataSource=self
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
extension LastRidesViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "lastRides", for: indexPath) as! LastRidesTableViewCell
        let imageName = photos[indexPath.row]
        cell.lastRideImageView?.image = UIImage(named: imageName)
        cell.labelText.text = names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
}
