import UIKit

class CarsViewController: UIViewController {
    
    @IBOutlet weak var birakisTimeLabel: UILabel!
    @IBOutlet weak var birakisLabel: UILabel!
    @IBOutlet weak var alisLabel: UILabel!
    @IBOutlet weak var alisTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sonucSayisi: UILabel!
    
    var carRatings: [Int: Double] = [:]
    
    var birakisTimeText: String?
    var birakisText: String?
    var alisTimeText: String?
    var alisText: String?
    
    var gunSayisi: Int?
    // ViewModel
    var carViewModel = CarViewModel()
    var reviewViewModel = ReviewViewModel()
    
    var cars: [CarModel] = []
    var car: CarModel?
    //veritabanı için
    var startLocationId: Int?
    var endLocationId: Int?
    
    var startLocation: String?
    var endLocation: String?
    
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.backButtonTitle = ""
        
        // UI güncellemeleri
        birakisLabel.text = birakisText
        birakisTimeLabel.text = birakisTimeText
        alisLabel.text = alisText
        alisTimeLabel.text = alisTimeText
        print("Başlangıç Tarihi: \(startDate ?? Date())")
        print("Bırakış Tarihi: \(endDate ?? Date())")
        print("Gün Sayısı: \(gunSayisi ?? 0)")
        
        // Özel UIButton oluştur
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // Dikey konum için transform uygula
        backButton.transform = CGAffineTransform(translationX: 0, y: -5) // `y: -5` butonu yukarı taşır
        
        fetchCars()
        
        // UIBarButtonItem olarak ekle
        let barButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func fetchCars() {
        carViewModel.getCars { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let carss):
                    // Filter cars by cityId
                    self?.cars = carss.filter { car in
                        car.locationId == self?.startLocationId
                    }
                    self?.sonucSayisi.text = "\(self!.cars.count) sonuç listeleniyor"
                    
                    // Fetch reviews and calculate average rating for each car
                    self?.fetchReviewsForCars()
                    
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchReviewsForCars() {
        for car in cars {
            reviewViewModel.getReviewsByCarId(for: car.id) { [weak self] success in
                if success {
                    // Yorumları al
                    let reviews = self?.reviewViewModel.reviews.filter { $0.carId == car.id } ?? []
                    let totalRating = reviews.reduce(0) { $0 + ($1.rating ?? 0) }
                    let averageRating = reviews.isEmpty ? 0 : Double(totalRating) / Double(reviews.count)
                    // Car ID'sine göre puanı kaydet
                    self?.carRatings[car.id] = averageRating
                    // Tabloları yeniden yükle
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } else {
                    print("Failed to fetch reviews for car \(car.id)")
                }
            }
        }
    }
}

extension CarsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarsTableViewCell
        let car = cars[indexPath.row]
        
        cell.carNameLabel.text = (car.brand ?? " ") + " " + car.model
        cell.aracSınıfı.text = "\(car.carClass)"
        cell.vitesDurumu.text = "\(car.transmissionType)"
        cell.toplamGunLabel.text = "Toplam Fiyat(\(gunSayisi!)):"
        cell.yolcuSayisi.text = "\(car.seatCount) Kişilik"
        cell.gunlukFiyat.text = "Günlük Fiyat: \(car.dailyPrice)₺"
        cell.benzinDurumu.text = "\(car.gasType)"
        
        // Dictionary'den puanı al
        if let averageRating = carRatings[car.id] {
            cell.puanDurumu.text = String(format: "%.1f", averageRating) + "★"
        } else {
            cell.puanDurumu.text = "No reviews"
        }
        
        if let gunSayisi = self.gunSayisi {
            let toplamFiyat = car.dailyPrice * Decimal(gunSayisi)
            cell.toplamFiyat.text = "\(toplamFiyat)₺"
        } else {
            cell.toplamFiyat.text = "Toplam Fiyat: -"
        }

        // Image URL handling
        if let imageUrl = URL(string: car.imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.carImageView.image = UIImage(data: data)
                    }
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        car = cars[indexPath.row]
        print("Selected car: \(car?.brand ?? "Unknown") \(car?.model ?? "Unknown")")
        let vc = storyboard?.instantiateViewController(identifier: "details") as! CarDetailsViewController
        vc.car = car
        vc.carId = car?.id
        vc.startDate = self.startDate
        vc.endDate = self.endDate
        vc.startLocationId = self.startLocationId
        vc.endLocationId = self.endLocationId
        vc.gunSayisi = gunSayisi
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
}
