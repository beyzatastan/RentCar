//
//  MainPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 18.10.2024.
//

import UIKit
import MapKit
import CoreLocation
class MainPageViewController: UIViewController, CLLocationManagerDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    
    var viewModelB = BookingViewModel()
    var viewModelC = CarViewModel()
    var viewModelR = ReviewViewModel()
    var viewModelL = LocationViewModel()


    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var currentPage = 0
    var timer:Timer?
    let photos = ["reklam1","reklam2","reklam3"]
    
    @IBOutlet weak var mapKit: MKMapView!
    let locationManager=CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
   

 
        
        self.navigationItem.hidesBackButton = true
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        view4.layer.cornerRadius = 10
        view5.layer.cornerRadius = 10
        scrollView.layer.cornerRadius = 10
        
        locationManager.delegate = self
        //en detaylı konumu almak için
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapKit.showsUserLocation = true
        
        scrollView.delegate = self
        setupScrollView()
        pageControl.numberOfPages = photos.count
        scrollView.isPagingEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollImages), userInfo: nil, repeats: true)
        scrollView.showsHorizontalScrollIndicator = false
        
        
        
    }
    @IBAction func rentPageButton(_ sender: Any) {
        let rentVc=storyboard?.instantiateViewController(identifier: "rent") as! RentViewController
        navigationController?.pushViewController(rentVc, animated: false)
    }
    
    @IBAction func personButton(_ sender: Any) {
        let personVc=storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        navigationController?.pushViewController(personVc, animated: false)
    }
    @IBAction func settingsButton(_ sender: Any) {
        let settingVc=storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(settingVc, animated: false)
    }
    
    func setupScrollView() {
        for i in 0..<photos.count {
            let imageView = UIImageView()
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: photos[i])
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            // Her bir imageView için frame ayarlıyoruz, aralarında boşluk olmayacak şekilde
            let xPosition = self.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            
            // ScrollView'in contentSize'ını resimlerin toplam genişliğine göre ayarla
            scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(photos.count)
            scrollView.addSubview(imageView)
        }
    }
    @objc func autoScrollImages() {
        currentPage += 1
        if currentPage >= photos.count {
            currentPage = 0
        }
        
        // Scroll işlemini gerçekleştir
        let xOffset = CGFloat(currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    deinit {
        // Timer'ı iptal et
        timer?.invalidate()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapKit.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func doStuff(){
        let carId = 2
        let customerId = 1
        
        viewModelR.getReviewsByCarId(for: carId) { success in
            if success {
                // UI'yi güncelle
                print(self.viewModelB.bookings)
            } else {
                print("Failed to fetch reviews")
            }
        }
        viewModelB.getBookingsByCustomerId(for: customerId) { success in
            if success {
                // UI'yi güncelle
                print(self.viewModelB.bookings)
            } else {
                print("Failed to fetch bookings")
            }
        }
               viewModelB.getBookingsByCarId(for: carId) { success in
                   if success {
                       // UI'yi güncelle
                       print(self.viewModelB.bookings)
                   } else {
                       print("Failed to fetch car by ıd")
                   }
               }
        viewModelC.getCar { success in
            if success {
                // Update your UI with viewModelC.cars
                print(self.viewModelC.cars)
            } else {
                print("Failed to fetch cars")
            }
        }
        
        let carModel = CarModel(
            id: 0, // Otomatik olarak belirlenmiş bir id kullanabilirsiniz, ya da backend tarafından atanacaktır.
            brand: "toyota",
            model: "corolla",
            year: 2019,
            licensePlate: "34tlm54",
            transmissionType: "otomatik",
            seatCount: 5,
            dailyPrice: 3500,
            supplierId: 1,
            supplier: nil, locationId: 1,  // Supplier için geçici olarak nil
            location: nil,  // Location için geçici olarak nil
            bookings: [],    // Bookings boş bir array
            images: [], reviews: []       // Resimler boş
        )

        viewModelC.addCar(car: carModel) { success in
            DispatchQueue.main.async {
                if success {
                    print("Car added successfully.")
                    // Update the UI or show success message
                } else {
                    print("Failed to add car.")
                    // Handle failure (show error message, etc.)
                }
            }
        }
        viewModelL.getLocationById(for: 1) { success in
                           if success {
                               print("Location fetched successfully")
                           } else {
                               print("Failed to fetch location")
                           }
                       }
            
        
          viewModelL.getLocation { result in
                     switch result {
                     case .success(_):
                         // Başarı durumunda UI'yi güncelle
                         DispatchQueue.main.async {
                             print("Şehirler başarıyla alındı: \(self.viewModelL.locations)")
                         }
                     case .failure(let error):
                         // Hata durumunda hata mesajını yazdır
                         DispatchQueue.main.async {
                             print("Hata: \(error.localizedDescription)")
                         }
                     }
                 }
        viewModelC.getCarById(for: carId) { success in
            DispatchQueue.main.async {
                if success {
                    // Access the car details from viewModel.cars
                    if let car = self.viewModelC.cars.first {
                        print("Car fetched: \(car.brand) \(car.model)")
                        // Update the UI with the car details
                        
                    } else {
                        print("No car found with ID \(carId)")
                    }
                } else {
                    print("Failed to fetch car with ID \(carId)")
                }
            }
        }
    }
}
