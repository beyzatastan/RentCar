//
//  CarsViewController.swift
//  RentCar
//
//  Created by beyza nur on 19.11.2024.
//

import UIKit

class CarsViewController: UIViewController {

    
    @IBOutlet weak var birakisTimeLabel: UILabel!
    @IBOutlet weak var birakisLabel: UILabel!
    @IBOutlet weak var alisLabel: UILabel!
    @IBOutlet weak var alisTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var birakisTimeText: String?
    var birakisText: String?
    var alisTimeText: String?
    var alisText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        navigationItem.backButtonTitle = ""
        birakisLabel.text = birakisText
        birakisTimeLabel.text = birakisTimeText
        alisLabel.text=alisText
        alisTimeLabel.text = alisTimeText
         
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
