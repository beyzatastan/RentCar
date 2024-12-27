
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
    
    var gunSayisi: Int?
    // ViewModel
    var carViewModel = CarViewModel()
    var cars: [CarModel] = []
    var car:CarModel?
    
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
        print(gunSayisi)
        
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
                    self?.cars = carss
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
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
        cell.yolcuSayisi.text = "\(car.seatCount) Kişilik"
        cell.gunlukFiyat.text = "Günlük Fiyat: \(car.dailyPrice)₺"
        cell.benzinDurumu.text = "\(car.gasType)"
       // cell.puanDurumu.text = "\(car.reviews)" ??
        if let gunSayisi = self.gunSayisi {
            let toplamFiyat = car.dailyPrice * Decimal(gunSayisi)
            cell.toplamFiyat.text = "\(toplamFiyat)₺"
        } else {
            cell.toplamFiyat.text = "Toplam Fiyat: -"
        }

            
        // İmaj URL'sini gösterme
        if let imageUrl = URL(string: car.imageUrl) {
            // Resmi yavaşça yükleyin
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
            // Seçilen aracı kaydediyoruz.
            car = cars[indexPath.row]
            print("Selected car: \(car?.brand ?? "Unknown") \(car?.model ?? "Unknown")")
        let vc = storyboard?.instantiateViewController(identifier: "details") as! CarDetailsViewController
        vc.car = car // Seçilen aracı detay sayfasına aktarıyoruz.
        vc.gunSayisi = gunSayisi
        navigationController?.pushViewController(vc, animated: true)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340 // Satır yüksekliğini belirleyin
    }
}
