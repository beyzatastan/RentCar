import Foundation

class CarWebService {
    static let shared = CarWebService() // Singleton pattern
    private init() {}


    
        
    func addCar(car: AddCarModel, completion: @escaping (Result<CarModel, Error>) -> Void) {
        
        // API URL
        guard let url = URL(string: "http://localhost:5163/api/CarController/addCar") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encoding customer data to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(car)
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
                let carResponse = try decoder.decode(CarResponse.self, from: data)
                print("burda")
                if let firstCar = carResponse.values.first {
                    completion(.success(firstCar))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No car data found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
    func getCars(completion: @escaping (Result<[CarModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Car/getCars"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse<CarModel>.self, from: data)
                completion(.success(apiResponse.values))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func gethCarsByUserId(userId: Int, completion: @escaping (Result<[CarModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Car/getCarsByUserId/\(userId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(ApiResponse<CarModel>.self, from: data)
                completion(.success(apiResponse.values))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func getCarById(for carId: Int, completion: @escaping (Result<CarModel, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Car/getCarById/\(carId)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    print("Error: Invalid response from server")
                    completion(.failure(NSError(domain: "InvalidResponse", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            
            guard let data = data, !data.isEmpty else {
                print("Received empty data or data is not valid")
                completion(.failure(NSError(domain: "EmptyData", code: -1, userInfo: nil)))
                return
            }
            
            // Veriyi yazdırarak kontrol et
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
            }
            
            do {
                let car = try JSONDecoder().decode(CarModel.self, from: data)
                completion(.success(car))
            } catch {
                print("JSON Decoding Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func deleteCar(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/CarController/deleteCarById/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to delete car"])))
            }
        }
        task.resume()
    }
    
}
