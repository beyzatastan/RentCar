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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gunlukFiyatLabel: UILabel!
    @IBOutlet weak var toplamFiyatLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var depozitoLabel: UILabel!
    @IBOutlet weak var yolcuSayisiLabel: UILabel!
    @IBOutlet weak var vitesLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aracNameLabel: UILabel!
    @IBOutlet weak var toplamFiyattLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reviewView: UIView!
    
    var car: CarModel?
    let reviewViewModel = ReviewViewModel()
    var gunSayisi:Int?
    var aracReviews: [ReviewModel] = []
    var review:ReviewModel?
    
    //veritabanı için
    var carId:Int?
    
    var startLocationId:Int?
    var endLocationId:Int?
    
    var startDate:Date?
    var endDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let car = car {
            aracNameLabel.text = (car.brand ?? " ") + " " + car.model
            gunlukFiyatLabel.text = "Günlük Fiyat: \(car.dailyPrice)₺"
            yolcuSayisiLabel.text = "\(car.seatCount)"
            vitesLabel.text = car.transmissionType
            benzinLabel.text = car.gasType
            depozitoLabel.text = "\(car.deposit)₺"
            toplamFiyattLabel.text="Toplam Fiyat(\(gunSayisi ?? 1) gün):"
            if let gunSayisi = self.gunSayisi {
                let toplamFiyat = car.dailyPrice * Decimal(gunSayisi)
                toplamFiyatLabel.text = "\(toplamFiyat)₺"
            } else {
                toplamFiyatLabel.text = " -"
            }
            // Eğer araç resmi varsa, resmi göster
            if let imageUrl = URL(string: car.imageUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        getReviewsByCarId(carId: carId!)
        tableView.dataSource=self
        tableView.delegate=self
        mainView.layer.cornerRadius=10
        reviewView.layer.cornerRadius = 10
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
        vc.carId=self.carId
        vc.startLocationId=self.startLocationId
        vc.endLocationId=self.endLocationId
        vc.endDate=self.endDate
        vc.startDate=self.startDate
        navigationController?.pushViewController(vc, animated: true)
    }
    func getReviewsByCarId(carId: Int) {
        reviewViewModel.getReviewsByCarId(for: carId) { success in
            if success {
                print(self.reviewViewModel.reviews)
                self.aracReviews = self.reviewViewModel.reviews
                self.tableView.reloadData() // Reload table view after fetching the reviews
            } else {
                print("Failed to fetch reviews")
            }
        }
    }
}

extension CarDetailsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aracReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewTableViewCell
       
        let review = aracReviews[indexPath.row]
        
        cell.commentLabel.text=review.comment
        cell.rateLabel.text="Değerlendirme: \(review.rating!)★"
       // cell.reviewDateLabel.text=review.dateCreated
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
