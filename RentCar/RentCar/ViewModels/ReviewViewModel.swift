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
