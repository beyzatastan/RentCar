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
    
    
    @IBOutlet weak var addButton: UIImageView!
    @IBOutlet weak var carsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsView.layer.cornerRadius = 10
        
        
        tableView.dataSource=self
        tableView.delegate = self
        navigationItem.hidesBackButton = true
        addButton.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        addButton.addGestureRecognizer(tapGesture)
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
    
    @objc func addButtonTapped() {
        let addCarVC = storyboard?.instantiateViewController(identifier: "addcar") as! AddCarViewController
        navigationController?.pushViewController(addCarVC, animated: true)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedImageName = photos[indexPath.row]
        let selectedModel = names[indexPath.row]
        let rentPageVC = storyboard?.instantiateViewController(identifier: "rent") as! RentPageViewController
        
        rentPageVC.selectedImage = UIImage(named: selectedImageName)
        rentPageVC.aracMarkaLabel?.text = selectedModel
        
        navigationController?.pushViewController(rentPageVC, animated: true)
    
    }
}
