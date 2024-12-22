//
//  SuppliersModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct SupplierModel: Codable {
    var id: Int
    var companyName: String
    var contactPerson: String
    var contactNumber: String
    var address: String
    var email: String
    var cars: [CarModel]? // Opsiyonel, tedarikçinin arabaları olabilir
    var reviews: [ReviewModel]? // Opsiyonel, tedarikçinin aldığı incelemeler
}
