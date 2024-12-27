//
//  OnayPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 27.11.2024.
//

import UIKit

class OnayPageViewController: UIViewController {
    var customerId: Int?
    var carId: Int?
    var startDate: Date = Date()
    var endDate: Date = Date()
    var startLocation: String = ""
    var endLocation: String = ""
    var totalPrice: Double = 0.0
    
    private var bookingVM = BookingViewModel()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var onayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
    }
    @IBAction func nextButton(_ sender: Any) {
        //booking oluştur
        let vc=storyboard?.instantiateViewController(identifier: "test") as! TestPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
