import Foundation
import Combine

class CarViewModel: ObservableObject {
    @Published var cars: [CarModel] = []
    @Published var car: CarModel?
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    
    
    func getCars(completion: @escaping (Result<[CarModel], Error>) -> Void) {
        CarWebService.shared.getCars { [weak self] result in
            switch result {
            case .success(let cars):
                self?.cars = cars
                print(cars)
                completion(.success(cars))
            case .failure(let error):
                print("Hata: \(error.localizedDescription), Detaylar: \(error)")
                completion(.failure(error))
            }
        }
    }
    func addCar(car: AddCarModel) {
        isLoading = true
        CarWebService.shared.addCar(car: car ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let car):
                    self?.car = car
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    func getCarById(for carId: Int, completion: @escaping (Bool) -> Void) {
        CarWebService.shared.getCarById(for: carId) { [weak self] result in
            if case let .success(car) = result {
                self?.cars = [car]
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func deleteCar(id: Int, completion: @escaping (Bool) -> Void) {
        CarWebService.shared.deleteCar(id: id) { result in
            completion(result.isSuccess)
        }
    }
}

extension Result {
    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}
