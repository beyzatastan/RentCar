//
//  CarImagesModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation
struct CarImageModel: Codable {
    let id: Int?
    let bookingId: Int
    let carId: Int?
    let customerId: Int?
    let isBeforeRental: Bool?
    let uploadDate: Date
    let imageUrls: String// The MIME type of the image (e.g., "image/jpeg", "image/png")
    
}
struct AddCarImageModel: Codable {
    var bookingId: Int
       var imageUrl1: String
       var imageUrl2: String
       var imageUrl3: String
       var imageUrl4: String
}

struct CarImageResponse: Codable {
    let message: String
    let bookingId: Int
}
