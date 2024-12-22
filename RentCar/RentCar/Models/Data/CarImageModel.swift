//
//  CarImagesModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation
struct CarImageModel: Codable {
    var id: Int
    var carId: Int
    var imageUrl: String
    var isPrimary: Bool
    var data: Data? // The image data
    var mimeType: String? // The MIME type of the image (e.g., "image/jpeg", "image/png")
}
