//
//  ReviewViewModel.swift
//  RentCar
//
//  Created by beyza nur on 22.12.2024.
//

import Foundation
class ReviewViewModel {
    
    var reviews: [ReviewModel] = []
    var review: ReviewModel?
    @Published var reviewMessage: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    let baseUrl = BaseUrl().baseUrl;
    
        func checkReviewExists(userId: Int, completion: @escaping (Bool, Error?) -> Void) {
            guard let url = URL(string: "http://localhost:5163/api/Review/check/\(userId)") else {
                completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(false, error)
                    return
                }

                guard let data = data else {
                    completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(Bool.self, from: data)
                    completion(result, nil)
                } catch {
                    completion(false, error)
                }
            }.resume()
    }
    func getReviewsByCarId(for carId: Int, completion: @escaping (Bool) -> Void) {
        ReviewWebService.shared.getReviewsByCarId(for: carId) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
                print("yorum gonderildi")
                completion(true)
            case .failure(let error):
                print("Error fetching reviews: \(error)")
                completion(false)
            }
        }
    }
    func addReview(review: AddReviewModel) {
        isLoading = true
        ReviewWebService.shared.addReview(review:review){ [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let review):
                    self?.review = review
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
