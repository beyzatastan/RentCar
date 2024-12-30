import UIKit

class LastRidesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,LastRidesTableViewCellDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lastRidesView: UIView!
    
    @IBOutlet weak var upView: UIView!
    var viewModelC = CarViewModel()
    var viewmodelB=BookingViewModel()
    var cars: [CarModel] = []  // Araçları tutacak dizi
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastRidesView.layer.cornerRadius = 10
        upView.layer.cornerRadius = 10
        upView.addSubview(lastRidesView)
        tableView.delegate = self
        tableView.dataSource = self

        
        // UserDefaults'ten userId'yi al
        if let userIdString = UserDefaults.standard.string(forKey: "userId"),
           let userIdInt = Int(userIdString) {
            self.userId = userIdInt
            print("User ID: \(userIdInt)")
        } else {
            print("Customer ID not found or invalid.")
            
        }
        
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(goBack))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        fetchBookings()
        }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

    func fetchBookings() {
        guard let userId = userId else {
            print("User ID is nil. Cannot fetch bookings.")
            return
        }
        
        viewmodelB.getBookingsByUserId(for: userId) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    // Rezervasyonlardan carId'leri al
                    let carIds = self?.viewmodelB.bookings.map { $0.carId! } ?? []
                    self?.fetchCars(by: carIds)
                    print("geldi")
                } else {
                    print("Failed to fetch bookings for user ID: \(userId)")
                }
            }
        }
    }
    private func fetchCars(by carIds: [Int]) {
        let dispatchGroup = DispatchGroup()
        var fetchedCars: [CarModel] = []

        // carIds listesi üzerinde döngü kurarak her bir aracı çekiyoruz
        for carId in carIds {
            dispatchGroup.enter()  // İşlem başladığında gruba katıl
            viewModelC.getCarById(for: carId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let car):
                        // Başarı durumunda car modelini fetchedCars'a ekle
                        fetchedCars.append(car)
                        print("Fetched car: \(car)")  // Burada car verisini yazdır
                    case .failure(let error):
                        // Hata durumunda hata mesajını yazdır
                        print("Failed to fetch car with ID: \(carId), Error: \(error.localizedDescription)")
                    }
                }
                dispatchGroup.leave()  // İşlem bittiğinde gruptan çık
            }
        }

        // Tüm işlemler tamamlandığında
        dispatchGroup.notify(queue: .main) { [weak self] in
            // FetchedCars listesini ve tableView'ı güncelle
            self?.cars = fetchedCars
            self?.tableView.reloadData()
            print("Fetched cars: \(fetchedCars)")  // Sonuçları kontrol et
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count  // Burada cars dizisini kullanıyoruz
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lastRides", for: indexPath) as! LastRidesTableViewCell
        let car = cars[indexPath.row]
        if let imageUrl = URL(string: car.imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.lastRideImage!.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.lastCarName.text = "\(car.brand ?? "") \(car.model ?? "")"
        cell.index = indexPath.row  // index değerini cell'e set et
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

   
    
    func didTapEvaluateButton(at index: Int) {
        print("Evaluate button tapped at index: \(index)")
        let car = cars[index]
        print("Car to evaluate: \(car.brand ?? "") \(car.model ?? "")")
        
        // Instantiate the ReviewViewController
        let vc = storyboard?.instantiateViewController(identifier: "review") as! ReviewViewController
        
        // Pass the car to the ReviewViewController
        vc.car = [car]  // Assuming you are passing the selected car as a single-item array (you can adjust based on your needs)
        
        // Push to ReviewViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
