//
//  CityModels.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.
//
import Foundation

// ViewModel sınıfı
class CityViewModel {
    var cities: [City] = [] // Şehirlerin listesini tutar
    
    // Şehir verilerini çekme fonksiyonu
    func fetchCities(completion: @escaping () -> Void) {
        WebService.shared.fetchCities { fetchedCities in
            if let fetchedCities = fetchedCities {
                self.cities = fetchedCities // Gelen şehirleri listeye ekle
            }
            completion()
        }
    }
}
