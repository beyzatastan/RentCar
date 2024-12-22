//
//  CarsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct CarModel: Codable {
    let id: Int // Unique identifier for each car
    let brand: String // Car brand
    let model: String // Car model
    let year: Int // Manufacturing year
    let licensePlate: String // License plate number
    let transmissionType: String // Transmission type
    let seatCount: Int // Number of seats
    let dailyPrice: Decimal // Daily rental price
    let supplierId: Int // Foreign key linking to the supplier
    let supplier: SupplierModel? // Navigation property
    let locationId: Int // Foreign key linking to the location
    let location: LocationModel? // Navigation property
    let bookings: [BookingModel] // List of bookings
    let images: [CarImageModel] // Car images
    let reviews: [ReviewModel] // Car reviews

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "Brand"
        case model = "Model"
        case year = "Year"
        case licensePlate = "LicensePlate"
        case transmissionType = "TransmissionType"
        case seatCount = "SeatCount"
        case dailyPrice = "DailyPrice"
        case supplierId = "SupplierId"
        case supplier = "Supplier"
        case locationId = "LocationId"
        case location = "Location"
        case bookings = "Bookings"
        case images = "Images"
        case reviews = "Reviews"
    }
}

struct ApiResponse<T: Codable>: Codable {
    let id: String // Unique identifier for the API response
    let values: [T] // List of decoded objects

    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case values = "$values"
    }
}
