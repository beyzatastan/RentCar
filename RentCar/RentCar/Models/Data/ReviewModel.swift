//
//  ReviewsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct ReviewModel: Codable {
    var id: Int
    var customerId: Int
    var customer: CustomerModel? // Optional, detaylı bilgi gerekebilir
    var supplierId: Int
    var supplier: SupplierModel? // Optional
    var carId: Int
    var car: CarModel? // Optional
    var rating: Int // 1-5 arası puan
    var comment: String
    var dateCreated: String // ISO 8601 formatında tarih (e.g., "2024-12-21T00:00:00Z")
}
