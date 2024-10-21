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
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var currentPage = 0
    var timer:Timer?
    let photos = ["reklam","bmw","dodge"]
  
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
    
    func setupScrollView() {
        for i in 0..<photos.count {
            let imageView = UIImageView()
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
    
    
    @IBAction func searchButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "search") as! SearchViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    
    @IBAction func favsButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "favs") as! FavoritesViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
    @IBAction func personButton(_ sender: Any) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "personal") as! PersonalPageViewController
        self.navigationController?.pushViewController(viewcontroller, animated: false)
    }
}
