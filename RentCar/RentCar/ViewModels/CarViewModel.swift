//
//  CarViewModel.swift
//  RentCar
//
//  Created by beyza nur on 22.12.2024.
//

import Foundation

class CarViewModel {

    // The list of cars will be populated after fetching the data
    var cars: [CarModel] = []
    
  
    func getCar(completion: @escaping (Bool) -> Void) {
        CarWebService.shared.getCars { [weak self] result in
            switch result {
            case .success(let cars):
                // Update the local model property with fetched cars
                self?.cars = cars
                completion(true)
            case .failure(let error):
                print("Error fetching cars: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    func addCar(car: CarModel, completion: @escaping (Bool) -> Void) {
        CarWebService.shared.addCar(car: car) { result in
            switch result {
            case .success(let message):
                print(message) // Optional: Log success message
                completion(true)  // Indicating success
            case .failure(let error):
                print("Error adding car: \(error.localizedDescription)")
                completion(false)  // Indicating failure
            }
        }
    }

    func getCarById(for carId: Int, completion: @escaping (Bool) -> Void) {
        CarWebService.shared.getCarById(for: carId) { [weak self] result in
            switch result {
            case .success(let car):
                self?.cars = [car] // Assign the single car wrapped in an array
                completion(true)
            case .failure(let error):
                print("Error fetching car: \(error.localizedDescription)")
                completion(false)
            }
        }
    }

    // Function to delete a car by ID
    func deleteCar(id: Int, completion: @escaping (Bool) -> Void) {
        CarWebService.shared.deleteCar(id: id) { result in
            switch result {
            case .success:
                print("Car deleted successfully.")
                completion(true)
            case .failure(let error):
                print("Error deleting car: \(error)")
                completion(false)
            }
        }
    }
}
