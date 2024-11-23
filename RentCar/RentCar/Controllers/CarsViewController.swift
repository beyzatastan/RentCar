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
        let vc=storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func nextButton(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier: "details") as! CarDetailsViewController
        navigationController?.pushViewController(vc, animated: true)
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
