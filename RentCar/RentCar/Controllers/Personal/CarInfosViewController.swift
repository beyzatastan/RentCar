//
//  CarInfosViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class CarInfosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let names = ["honda civic","mercedes g"]
    let photos = ["lale","kule"]
    
    @IBOutlet weak var carsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsView.layer.cornerRadius = 10
        
        tableView.dataSource=self
        tableView.delegate = self
       
    }
    
}
extension CarInfosViewController{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cars", for: indexPath) as! CarsTableViewCell
        cell.carsImageView.image=UIImage(named: photos[indexPath.row])
        cell.label.text=names[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
