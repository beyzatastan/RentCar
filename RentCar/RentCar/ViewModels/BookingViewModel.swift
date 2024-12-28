//
//  BookingViewModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

class BookingViewModel {

    var bookings: [BookingModel] = []
    
    @Published var bookingMessage: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var booking: BookingModel?
    var bookingId:Int?
    

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
    func addBooking(booking: AddBookingModel, completion: @escaping (Int?) -> Void) {
        isLoading = true
        BookingWebService.shared.addBooking(booking: booking) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    print("Booking ID: \(response.bookingId)") // Confirm bookingId is correct
                    self?.fetchBookingDetails(bookingId: response.bookingId, completion: completion)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    }

    func fetchBookingDetails(bookingId: Int, completion: @escaping (Int?) -> Void) {
        BookingWebService.shared.fetchBookingById(bookingId: bookingId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let booking):
                    self?.booking = booking
                    completion(booking.id) // Pass the ID to completion
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(nil)
                }
            }
        }
    }

}

