//
//  ReviewsModel.swift
//  RentCar
//
//  Created by beyza nur on 21.12.2024.
//

import Foundation
class ReviewWebService {
    
    static let shared = ReviewWebService() // Singleton pattern
    
    private init() {}
    
    func getReviewsByCarId(for carId: Int, completion: @escaping (Result<[ReviewModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/ReviewContoller/getReviewsByCarId/\(carId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Hata kontrolü
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204 else {
                print("Invalid response or non-200 status code.")
                completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response or non-200 status code."])))
                return
            }
            
            // Veriyi çözümleme (decode)
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString)") // API yanıtını konsola yazdırın
                }
                
                do {
                    let reviews = try JSONDecoder().decode([ReviewModel].self, from: data)
                    print("Reviews for Car \(carId): \(reviews)")
                    completion(.success(reviews)) // Başarı durumunda completion handler'ı çağır
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error)) // JSON çözümleme hatasında completion handler'ı çağır
                }
            }
        }
        task.resume()
    }
}
