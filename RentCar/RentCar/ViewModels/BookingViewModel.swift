//
//  BookingViewModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

class BookingViewModel {

    var bookings: [BookingModel] = []

    func getBookingsByCarId(for carId: Int, completion: @escaping (Bool) -> Void) {
        BookingWebService.shared.getBookingsByCarId(for: carId) { [weak self] result in
            switch result {
            case .success(let bookings):
                self?.bookings = bookings
                completion(true)
            case .failure(let error):
                print("Error fetching bookings: \(error)")
                completion(false)
            }
        }
    }
    
    func getBookingsByCustomerId(for customerId: Int, completion: @escaping (Bool) -> Void) {
        BookingWebService.shared.getBookingsByCustomerId(for: customerId) { [weak self] result in
            switch result {
            case .success(let bookings):
                self?.bookings = bookings
                completion(true)
            case .failure(let error):
                print("Error fetching bookings: \(error)")
                completion(false)
            }
        }
    }
}
