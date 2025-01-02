//
//  BookingsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct BookingModel: Codable {
    let id: Int? // This should match the "id" field in the response
    let customerId: Int?
    let carId: Int?
    let startDate: String?
    let endDate: String?
    let startLocationId: Int?
    let endLocationId: Int?

enum CodingKeys: String, CodingKey {
    case id = "id"
    case customerId = "customerId"
    case carId = "carId"
    case startDate = "startDate"
    case endDate = "endDate"
    case startLocationId = "startLocationId"
    case endLocationId = "endLocationId"
}
}

struct AddBookingModel: Codable {
    let customerId: Int
    let carId: Int
    let startDate: String // ISO 8601 formatında tarih
    let endDate: String   // ISO 8601 formatında tarih
    let startLocationId: Int
    let endLocationId: Int
}
struct BookingResponse: Codable {
    let values: [BookingModel]
    
    private enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}
struct BookingResponsee: Codable {
    let message: String
    let bookingId: Int
}


