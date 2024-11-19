//
//  CarsViewController.swift
//  RentCar
//
//  Created by beyza nur on 19.11.2024.
//

import UIKit

class CarsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        self.navigationItem.hidesBackButton = true
    }
   
    @IBAction func backButton(_ sender: Any) {
        let rent=storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
        navigationController?.pushViewController(rent, animated: false)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension CarsViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}
