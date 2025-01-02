//
//  LastViewController.swift
//  RentCar
//
//  Created by beyza nur on 28.12.2024.
//

import UIKit

class LastViewController: UIViewController {


    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mainVieww: UIView!
    @IBOutlet weak var upView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainVieww.layer.cornerRadius = 10
        upView.layer.cornerRadius = 10
        bottomView.layer.cornerRadius = 10
    }
    
    @IBAction func OKButtonClicked(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier:"main") as! MainPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
