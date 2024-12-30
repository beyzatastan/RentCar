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
    func getCarById(for carId: Int, completion: @escaping (Result<CarModel, Error>) -> Void) {
        CarWebService.shared.getCarById(for: carId) { [weak self] result in
            switch result {
            case .success(let car):
                self?.cars = [car]  // Başarılı durumda car'ı cars listesine ekliyoruz
                completion(.success(car))  // Başarı durumunda car modelini döndürüyoruz
            case .failure(let error):
                print("Hata: \(error.localizedDescription), Detaylar: \(error)")  // Hata mesajı yazdırıyoruz
                completion(.failure(error))  // Hata durumunda error döndürüyoruz
            }
        }
    }

    
    func getCarByUserId(for userId: Int, completion: @escaping (Bool) -> Void) {
           CarWebService.shared.gethCarsByUserId(userId: userId) { [weak self] result in
               switch result {
                       case .success(let cars): // Dizi döndürülür
                           self?.cars = cars // Gelen diziyi atıyoruz
                           completion(true)
                       case .failure(let error): // Hata durumu
                           print("Failed to fetch cars: \(error.localizedDescription)")
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
