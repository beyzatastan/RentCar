import Foundation

class CarWebService {
    
    static let shared = CarWebService() // Singleton pattern
    
    private init() {}
    var cars: [CarModel] = []
    
    func addCar(car: CarModel, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/CarController/addCar"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Append car details
        func appendParam(name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append(value.data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // Append car properties
        appendParam(name: "brand", value: car.brand)
        appendParam(name: "model", value: car.model)
        appendParam(name: "year", value: "\(car.year)")
        appendParam(name: "licensePlate", value: car.licensePlate)
        appendParam(name: "transmissionType", value: car.transmissionType)
        appendParam(name: "seatCount", value: "\(car.seatCount)")
        appendParam(name: "dailyPrice", value: "\(car.dailyPrice)")
        
        if let supplier = car.supplier {
            appendParam(name: "supplierId", value: "\(supplier.id)")
        }
        
        if let location = car.location {
            appendParam(name: "locationId", value: "\(location.id)")
        }
        
        // Add images if available
        // Add images if available
        if !car.images.isEmpty {
            for image in car.images {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"\(image.imageUrl)\"\r\n".data(using: .utf8)!)
                
                // If mimeType is available, use it, otherwise default to a common type
                let mimeType = image.mimeType ?? "application/octet-stream"
                body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                
                // If the image has data, append it, else skip it
                if let imageData = image.data {
                    body.append(imageData)
                }
                
                body.append("\r\n".data(using: .utf8)!)
            }
        }
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("API Response: \(responseString)")
                completion(.success("Car added successfully"))
            } else {
                completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to add car"])))
            }
        }
        
        task.resume()
    }
    
    func getCars(completion: @escaping (Result<[CarModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Car/getCars"
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
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
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
                    let cars = try JSONDecoder().decode([CarModel].self, from: data)
                    print("Cars: \(cars)")
                    completion(.success(cars)) // Başarı durumunda completion handler'ı çağır
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error)) // JSON çözümleme hatasında completion handler'ı çağır
                }
            }
        }
        task.resume()
    }
    
    func getCarById(for carId: Int, completion: @escaping (Result<CarModel, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/Car/getCarById/\(carId)"
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
                    let apiResponse = try JSONDecoder().decode(ApiResponse<CarModel>.self, from: data)
                    if let car = apiResponse.values.first {
                        print("Car fetched: \(car)")
                        completion(.success(car))
                    } else {
                        print("No car found.")
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No car found."])))
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    // Delete a car by ID
    func deleteCar(id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/CarController/deleteCarById/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204{
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "APIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to delete car"])))
            }
        }
        
        task.resume()
    }
    
    
}
