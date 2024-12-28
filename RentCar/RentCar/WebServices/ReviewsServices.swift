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
    func addReview(review: AddReviewModel, completion: @escaping (Result<ReviewModel, Error>) -> Void) {
        // API URL
        guard let url = URL(string: "http://localhost:5163/api/ReviewContoller/addReview") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encoding customer data to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(review)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        // URLSession to send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            // Sunucudan gelen veriyi yazdır
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Sunucudan Gelen Yanıt: \(jsonString)")
            }

            do {
                // JSON decode et
                let decoder = JSONDecoder()
                let reviewResponse = try decoder.decode(ReviewResponse.self, from: data)

                if let firstReview = reviewResponse.values.first {
                    completion(.success(firstReview))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No review data found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
    
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
                    let reviewsResponse = try JSONDecoder().decode(ReviewResponse.self, from: data)
                    print("Reviews for Car \(carId): \(reviewsResponse.values)")
                    completion(.success(reviewsResponse.values)) // Pass the decoded reviews to the completion handler
                          } catch {
                              print("Error decoding JSON: \(error)")
                              completion(.failure(error)) // Pass the error to the completion handler if decoding fails
                          }
                      }
        }
        task.resume()
    }
}
