import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [LocationModel] = []
    @Published var location: LocationModel?
    
    func getLocation(completion: @escaping (Result<[LocationModel], Error>) -> Void) {
        LocationWebServices.shared.getLocations { [weak self] result in
            switch result {
            case .success(let locations):
                self?.locations = locations
                completion(.success(locations))
            case .failure(let error):
                print("Hata: \(error.localizedDescription), Detaylar: \(error)")
                completion(.failure(error))
            }
        }
    }

    func getLocationById(for locationId: Int, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        LocationWebServices.shared.getLocationById(for: locationId) { [weak self] result in
            switch result {
            case .success(let location):
                self?.location = location
                completion(.success(location))
            case .failure(let error):
                print("Error fetching location: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
 
}
