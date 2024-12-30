//
//  LastViewController.swift
//  RentCar
//
//  Created by beyza nur on 28.12.2024.
//

import UIKit

class LastViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func OKButtonClicked(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier:"main") as! MainPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
