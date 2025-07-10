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
        navigationItem.backButtonTitle = ""
        
        // Özel UIButton oluştur
          let backButton = UIButton(type: .system)
          backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
          backButton.tintColor = .white
          backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
          backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
          
          // Dikey konum için transform uygula
          backButton.transform = CGAffineTransform(translationX: 0, y: -5) // `y: -5` butonu yukarı taşır
          
          // UIBarButtonItem olarak ekle
          let barButtonItem = UIBarButtonItem(customView: backButton)
          navigationItem.leftBarButtonItem = barButtonItem
      }

      @objc func backButtonTapped() {
          navigationController?.popViewController(animated: true)
      }

    
    
    @IBAction func OKButtonClicked(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier:"main") as! MainPageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
