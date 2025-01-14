//
//  OnayPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 27.11.2024.
//

import UIKit

class OnayPageViewController: UIViewController {
    
    //veritabanı için
    var customerId: Int?
    var carId:Int?
    
    var startLocationId:Int?
    var endLocationId:Int?
    
    var startDate:Date?
    var endDate:Date?
    
  
    
    private var bookingVM = BookingViewModel()
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var onayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customerIdString = UserDefaults.standard.string(forKey: "customerId"),
                   let customerIdInt = Int(customerIdString) {
                    self.customerId = customerIdInt 
                    print("customerId: \(customerIdInt)")
                } else {
                    print("Customer ID not found or invalid.")
                }
                
        print("customerId: \(String(describing: customerId))")
        print("carId: \(String(describing: carId))")
        print("startDate: \(String(describing: startDate))")
        print("endDate: \(String(describing: endDate))")
        print("startLocationId: \(String(describing: startLocationId))")
        print("endLocationId: \(String(describing: endLocationId))")

        mainView.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
    }
    @IBAction func nextButton(_ sender: Any) {
        
        // Safely unwrap values before creating newBooking
              if let customerId = customerId,
                 let carId = carId,
                 let startDate = startDate,
                 let endDate = endDate,
                 let startLocationId = startLocationId,
                 let endLocationId = endLocationId {
                  
                  let newBooking = AddBookingModel(
                      customerId: customerId,
                      carId: carId,
                      startDate: convertDateToString(date: startDate),
                      endDate: convertDateToString(date: endDate),
                      startLocationId: startLocationId,
                      endLocationId: endLocationId
                  )
                  
                  bookingVM.addBooking(booking: newBooking) { bookingId in
                      if let bookingId = bookingId {
                          let vc = self.storyboard?.instantiateViewController(identifier: "test") as! TestPageViewController
                          vc.bookingId = bookingId
                          vc.customerId = self.customerId
                          vc.carId = self.carId
                          vc.startLocationId = self.startLocationId
                          vc.endLocationId = self.endLocationId
                          vc.endDate = self.endDate
                          vc.startDate = self.startDate
                          
                          // Son olarak geçişi sağlıyoruz
                          self.navigationController?.pushViewController(vc, animated: true)
                      } else {
                          print("Booking ID could not be fetched.")
                      }
                  }
              } else {
                  print("Missing required booking details.")
              }
          }
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Veya ihtiyacınıza uygun bir format belirleyin
        return dateFormatter.string(from: date)
    }

    
}
