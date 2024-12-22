//
//  CustomerModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation
struct CustomerModel: Codable {
    var id: Int
    var userId: Int
    var identityNumber: String
    var drivingLicenseIssuedDate: String // ISO 8601 format
    var drivingLicenseNumber: String
    var birthDate: String // ISO 8601 format
    var phone: String
    var city: String
    var district: String
    var address: String
    var postalCode: String
    var reviews: [ReviewModel] = []
    var bookings: [BookingModel] = []
}
