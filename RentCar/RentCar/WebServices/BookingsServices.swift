import Foundation

class BookingWebService {
    
    static let shared = BookingWebService() // Singleton pattern
    
    private init() {}
    
    func getBookingsByCustomerId(for customerId: Int, completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/BookingsContoller/getBookingsByCustomer/\(customerId)"
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
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204  else {
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
                    let bookings = try JSONDecoder().decode([BookingModel].self, from: data)
                    print("Bookings for Customer \(customerId): \(bookings)")
                    completion(.success(bookings)) // Başarı durumunda completion handler'ı çağır
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error)) // JSON çözümleme hatasında completion handler'ı çağır
                }
            }
        }
        task.resume()
    }
    func getBookingsByCarId(for carId: Int, completion: @escaping (Result<[BookingModel], Error>) -> Void) {
        let urlString = "http://localhost:5163/api/BookingsContoller/getBookingsByCar/\(carId)"
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
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 || httpResponse.statusCode == 204 else {
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
                    let bookings = try JSONDecoder().decode([BookingModel].self, from: data)
                    print("Bookings for Car \(carId): \(bookings)")
                    completion(.success(bookings)) // Başarı durumunda completion handler'ı çağır
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error)) // JSON çözümleme hatasında completion handler'ı çağır
                }
            }
        }
        task.resume()
    }
    
    func addBooking(booking: AddBookingModel, completion: @escaping (Result<BookingResponse, Error>) -> Void) {
        // API URL
        guard let url = URL(string: "http://localhost:5163/api/BookingsContoller/addBooking") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encoding customer data to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(booking)
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
            
            do {
                // Decode the response into CustomerResponse
                let decoder = JSONDecoder()
                let bookingResponse = try decoder.decode(BookingResponse.self, from: data)
                completion(.success(bookingResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchBookingById(bookingId: Int, completion: @escaping (Result<BookingModel, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:5163/api/BookingsContoller/getBookingById/\(bookingId)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            // Log the raw response for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
            }

            do {
                let decoder = JSONDecoder()
                let booking = try decoder.decode(BookingModel.self, from: data)
                completion(.success(booking))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}

