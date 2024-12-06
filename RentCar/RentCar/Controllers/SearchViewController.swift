//
//  SearchViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var lastSearchView: UIView!
    
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var buttonView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        buttonView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 10
        lastSearchView.layer.cornerRadius = 10
        tabView.layer.cornerRadius = 10
    }
    
    
    
    
    @IBAction func homeButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "main") as! MainPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func personButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    @IBAction func favsButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "favs") as! FavoritesViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
}
