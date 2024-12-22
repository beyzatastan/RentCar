//
//  ReviewViewModel.swift
//  RentCar
//
//  Created by beyza nur on 22.12.2024.
//

import Foundation
class ReviewViewModel {
    
    var reviews: [ReviewModel] = []
    
    func getReviewsByCarId(for carId: Int, completion: @escaping (Bool) -> Void) {
        ReviewWebService.shared.getReviewsByCarId(for: carId) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
                completion(true)
            case .failure(let error):
                print("Error fetching reviews: \(error)")
                completion(false)
            }
        }
    }
}
