import Foundation

class CustomerWebService {
    
    func addCustomer(customer: AddCustomerModel, completion: @escaping (Result<CustomerModel, Error>) -> Void) {
        // API URL
        guard let url = URL(string: "http://localhost:5163/api/Customer/addCustomer") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encoding customer data to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(customer)
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
                let customerResponse = try decoder.decode(CustomerResponse.self, from: data)

                if let firstCustomer = customerResponse.values.first {
                    completion(.success(firstCustomer))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No customer data found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()

    }
}
