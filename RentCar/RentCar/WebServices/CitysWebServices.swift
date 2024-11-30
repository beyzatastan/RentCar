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
        guard let url = URL(string: "https://turkiyeapi.dev/api/v1/cities") else {
            print("Geçersiz URL.")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Veri boş.")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CityModel.self, from: data)
                completion(response.data)
            } catch {
                print("JSON çözümleme hatası: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
