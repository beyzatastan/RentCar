//
//  LocationsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation

struct LocationModel: Codable {
    var id: Int
    var city: String
    var cars: [CarModel] = []
}
