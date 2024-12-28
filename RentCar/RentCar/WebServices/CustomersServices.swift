import Foundation

class CustomerWebService {
    
    func addCustomer(customer: AddCustomerModel, completion: @escaping (Result<CustomerResponse, Error>) -> Void) {
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
            
            do {
                // Decode the response into CustomerResponse
                let decoder = JSONDecoder()
                let customerResponse = try decoder.decode(CustomerResponse.self, from: data)
                completion(.success(customerResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch customer details after successful creation
    func fetchCustomerById(customerId: Int, completion: @escaping (Result<CustomerModel, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:5163/api/Customer/getCustomerById/\(customerId)") else {
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
            
            do {
                // Decode the customer details into CustomerModel
                let decoder = JSONDecoder()
                let customer = try decoder.decode(CustomerModel.self, from: data)
                completion(.success(customer))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
