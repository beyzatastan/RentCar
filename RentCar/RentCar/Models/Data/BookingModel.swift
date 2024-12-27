//
//  BookingsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct BookingModel: Codable {
    let id: Int?
    let customerId: Int?
    let carId: Int?
    let startDate: String? // ISO 8601 formatında tarih
    let endDate: String?  // ISO 8601 formatında tarih
    let totalPrice: Double?
    let startLocationId: Int?
    let endLocationId: Int?
    let deposit: Double?
    let startLocation: String?
    let endLocation: String?

enum CodingKeys: String, CodingKey {
    case id = "BookingId"
    case customerId = "CustomerId"
    case carId = "CarId"
    case startDate = "StartDate"
    case endDate = "EndDate"
    case totalPrice = "TotalPrice"
    case startLocationId = "StartLocationId"
    case endLocationId = "EndLocationId"
    case deposit = "Deposit"
    case startLocation = "StartLocation"
    case endLocation = "EndLocation"
}
}

struct AddBookingModel: Codable {
    let customerId: Int
    let carId: Int
    let startDate: String // ISO 8601 formatında tarih
    let endDate: String   // ISO 8601 formatında tarih
    let startLocationId: Int
    let endLocationId: Int
    let deposit: Double
    let startLocation: String?
    let endLocation: String?
}
struct BookingResponse: Codable {
    var values: [BookingModel]
    
    enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}

