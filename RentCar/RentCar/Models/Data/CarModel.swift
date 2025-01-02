//
//  CarsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct CarModel: Codable {
    let id: Int // Unique identifier for each car
    let brand: String? // Car brand
    let model: String // Car model
    let year: Int // Manufacturing year
    let licensePlate: String // License plate number
    let transmissionType: String // Transmission type
    let seatCount: Int // Number of seats
    let dailyPrice: Decimal // Daily rental price
    let deposit: Decimal
    let gasType: String
    let carClass: String
    let supplierId: Int // Foreign key linking to the supplier
    let supplier: SupplierModel? // Navigation property
    let locationId: Int // Foreign key linking to the location
    let location: LocationModel? // Navigation property
    let imageUrl: String
    let bookings: BookingModel? // List of bookings
    let reviews: ReviewModel? // Car reviews
    

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case model = "model"
        case year = "year"
        case deposit = "deposit"
        case gasType = "gasType"
        case carClass = "carClass"
        case licensePlate = "licensePlate"
        case transmissionType = "transmissionType"
        case seatCount = "seatCount"
        case dailyPrice = "dailyPrice"
        case supplierId = "supplierId"
        case supplier = "supplier"
        case locationId = "locationId"
        case location = "location"
        case imageUrl = "imageUrl"  // Buradaki düzeltme
        case bookings = "bookings"
        case reviews = "reviews"
    }
}
struct ApiResponse<T: Decodable>: Decodable {
    let values: [T]
    
    enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}


struct AddCarModel: Codable {
    let brand: String? // Car brand
    let model: String // Car model
    let year: Int // Manufacturing year
    let licensePlate: String // License plate number
    let transmissionType: String // Transmission type
    let seatCount: Int // Number of seats
    let dailyPrice: Decimal // Daily rental price
    let deposit: Decimal
    let gasType: String
    let carClass: String
    let supplierId: Int // Foreign key linking to the supplier
    let locationId: Int // Foreign key linking to the location
    let imageUrl: String
}
struct CarResponse: Codable {
    var values: [CarModel]
    
    enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}
