//
//  PersonalPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class PersonalPageViewController: UIViewController {

    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view1.layer.cornerRadius = 10
    }

    @IBAction func homeButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "search") as! SearchViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    @IBAction func favsButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "favs") as! FavoritesViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
}
