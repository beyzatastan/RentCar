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
    
    func addBooking(_ booking: BookingModel, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "http://localhost:5163/api/BookingsContoller/addBooking"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Booking verisini JSON formatına dönüştür
        do {
            let jsonData = try JSONEncoder().encode(booking)
            request.httpBody = jsonData
        } catch {
            print("Error encoding booking data: \(error)")
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
            
            // Başarı durumu
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString)")
                }
                completion(.success("Booking created successfully")) // Başarı durumunda completion handler'ı çağır
            }
        }
        task.resume()
    }
}
