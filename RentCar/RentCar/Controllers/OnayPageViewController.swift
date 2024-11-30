//
//  OnayPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 27.11.2024.
//

import UIKit

class OnayPageViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var onayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
    }
    @IBAction func nextButton(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier: "test") as! TestPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
