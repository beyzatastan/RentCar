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
    var cars: [CarModel]? 
}
enum CodingKeys: String, CodingKey {
       case id = "id"
       case city = "city"
       case cars = "cars" // Eğer farklı bir anahtar ismi varsa, onu buraya yazmalısınız
   }

  
