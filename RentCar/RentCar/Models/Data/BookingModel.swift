//
//  BookingsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct BookingModel: Codable {
let bookingId: Int
let customerId: Int
let customerName: String
let carId: Int
let carModel: String
let startLocation: String
let endLocation: String
let startDate: String
let endDate: String
let totalPrice: Double

enum CodingKeys: String, CodingKey {
    case bookingId = "BookingId"
    case customerId = "CustomerId"
    case customerName = "CustomerName"
    case carId = "CarId"
    case carModel = "CarModel"
    case startLocation = "StartLocation"
    case endLocation = "EndLocation"
    case startDate = "StartDate"
    case endDate = "EndDate"
    case totalPrice = "TotalPrice"
}
}
