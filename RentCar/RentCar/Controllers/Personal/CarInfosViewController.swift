//
//  CarInfosViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class CarInfosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let names = ["bmw 3.20 i","dodge charger"]
    let photos = ["bmw","dodge"]
  
    
    @IBOutlet weak var carsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsView.layer.cornerRadius = 10

        
        tableView.dataSource=self
        tableView.delegate = self
        addButton.frame = CGRect(x: 300, y: 550, width: 100, height: 200)
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
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let addcarvs=storyboard?.instantiateViewController(identifier: "addcar") as! AddCarViewController
        navigationController?.pushViewController(addcarvs, animated: true)
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
