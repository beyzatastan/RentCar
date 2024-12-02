//
//  CitysWebServices.swift
//  RentCar
//
//  Created by beyza nur on 30.11.2024.
//
import Foundation

class WebService {
    
    static let shared = WebService()
    
    func fetchCities(completion: @escaping ([City]?) -> Void) {
        let url = URL(string: "https://turkiyeapi.dev/api/v1/provinces")! // Gerçek API URL'si
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Veri boş!")
                completion(nil)
                return
            }
            
            //if data == data {
               // print("Gelen veri: \(String(data: data, encoding: .utf8) ?? "Geçersiz veri")")
            //  }
            do {
                // CityModel'i decode et
                let cityModel = try JSONDecoder().decode(CityModel.self, from: data)
                completion(cityModel.data) // Şehirleri döndür
            } catch {
                print("JSON çözümleme hatası: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
