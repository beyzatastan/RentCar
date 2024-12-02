//
//  CityModel.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.
//import Foundation

// CityModel, JSON verisinin ana yapısını temsil eder
struct CityModel: Codable {
    let status: String // API'den gelen durum
    let data: [City] // Şehirlerin bulunduğu dizi
}

// City, her bir şehri temsil eder
struct City: Codable {
    let id: Int // Şehir ID'si
    let name: String // Şehir adı
    let districts: [District] // Şehirdeki ilçeler
}

// District, her bir ilçeyi temsil eder
struct District: Codable {
    let id: Int // İlçe ID'si
    let name: String // İlçe adı
}
