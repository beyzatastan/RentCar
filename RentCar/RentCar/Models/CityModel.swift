//
//  CityModel.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.
//

struct CityModel: Codable {
  
    let data: [City]
}
struct City: Codable {
    let id: Int
    let name: String
    let districts: [District]
}

struct District: Codable {
    let id: Int
    let name: String
}
