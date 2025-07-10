import Foundation

class CustomerWebService {
    let baseUrl = BaseUrl().baseUrl

    func addCustomer(customer: AddCustomerModel, completion: @escaping (Result<CustomerResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/Customer/addCustomer") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(customer)
            request.httpBody = jsonData
            // Gönderilen JSON verisini yazdır
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Gönderilen JSON: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Geçersiz sunucu yanıtı"])))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = "Sunucu hatası: \(httpResponse.statusCode)"
                if let data = data, let errorBody = String(data: data, encoding: .utf8) {
                    print("Sunucu hata yanıtı: \(errorBody)")
                }
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Veri alınamadı"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let customerResponse = try decoder.decode(CustomerResponse.self, from: data)
                completion(.success(customerResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCustomerById(customerId: Int, completion: @escaping (Result<CustomerModel, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/Customer/getCustomerById/\(customerId)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorMessage = "Sunucu hatası: \((response as? HTTPURLResponse)?.statusCode ?? 0)"
                completion(.failure(NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Veri alınamadı"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let customer = try decoder.decode(CustomerModel.self, from: data)
                completion(.success(customer))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
