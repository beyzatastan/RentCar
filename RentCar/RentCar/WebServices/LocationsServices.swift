import Foundation

class LocationWebServices {
    
    static let shared = LocationWebServices() // Singleton pattern
    
    private init() {}
    func getLocations(completion: @escaping (Result<[LocationModel], Error>) -> Void) {
        let url = URL(string: "http://localhost:5163/api/Location/getAllLocations")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            // Gelen veriyi kontrol etmek için JSON'u yazdır
            if let jsonString = String(data: data, encoding: .utf8) {
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse<LocationModel>.self, from: data)
                completion(.success(apiResponse.values))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    func getLocationById(for locationId: Int, completion: @escaping (Result<LocationModel, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Location/getLocationById/\(locationId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204 else {
                let error = NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response or non-200 status code."])
                print("Invalid response or status code.")
                completion(.failure(error))
                return
            }
            
            if let data = data {
                // API'den dönen JSON'u konsola yazdır
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response JSON: \(jsonString)")
                }
                
                do {
                    // JSON'u decode et
                    let apiResponse = try JSONDecoder().decode(ApiResponse<LocationModel>.self, from: data)
                    if let location = apiResponse.values.first {
                        print("location fetched: \(location)")
                        completion(.success(location))
                    } else {
                        print("No location found.")
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No location found."])))
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
