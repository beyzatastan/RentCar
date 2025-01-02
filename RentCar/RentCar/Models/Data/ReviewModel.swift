//
//  ReviewsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct ReviewModel: Codable {
    var id: Int?
    var customerId: Int?// Optional, detaylı bilgi gerekebilir
    var supplierId: Int?// Optional
    var carId: Int?
    var rating: Int? // 1-5 arası puan
    var comment: String?
    var dateCreated: String? // ISO 8601 formatında tarih (e.g., "2024-12-21T00:00:00Z")
}
struct AddReviewModel: Codable {
    var customerId: Int?// Optional, detaylı bilgi gerekebilir
    var supplierId: Int?// Optional
    var carId: Int?
    var rating: Int? // 1-5 arası puan
    var comment: String?
    var dateCreated: String?
    
    enum CodingKeys: String, CodingKey {
           case customerId
           case supplierId
           case carId
           case rating
           case comment
           case dateCreated = "createDate"
       }
}
struct ReviewResponse: Codable {
    var values: [ReviewModel]
    
    enum CodingKeys: String, CodingKey {
        case values = "$values"
    }
}
