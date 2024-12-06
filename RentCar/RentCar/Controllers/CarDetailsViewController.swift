//
//  CarDetailsViewController.swift
//  RentCar
//
//  Created by beyza nur on 21.11.2024.
//

import UIKit

class CarDetailsViewController: UIViewController {

    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var teslimYeriLabel: UILabel!
    @IBOutlet weak var benzinLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var surusView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var surucuYasiLabel: UILabel!
    @IBOutlet weak var gunlukFiyatLabel: UILabel!
    @IBOutlet weak var ehliyetYiliLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var depozitoLabel: UILabel!
    @IBOutlet weak var yolcuSayisiLabel: UILabel!
    @IBOutlet weak var vitesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aracNameLabel: UILabel!
    @IBOutlet weak var toplamFiyattLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.cornerRadius=10
        surusView.layer.cornerRadius=10
        toplamFiyattLabel.layer.cornerRadius=5
        toplamFiyattLabel.layer.masksToBounds=true
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

    

    @IBAction func kiralaButton(_ sender: Any) {
        let vc=storyboard?.instantiateViewController(identifier: "fatura") as! FaturaViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
