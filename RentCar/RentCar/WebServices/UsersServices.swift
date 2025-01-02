//
//  UsersServices.swift
//  RentCar
//
//  Created by beyza nur on 30.12.2024.
//

import Foundation
class UserWebServices {
    
    func addUser(user: AddUserModel, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        // API URL
        guard let url = URL(string: "http://localhost:5163/api/User/addUser") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encoding customer data to JSON
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(user)
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
                let userResponse = try decoder.decode(UserResponse.self, from: data)
                completion(.success(userResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch customer details after successful creation
    func fetchUserById(userId: Int, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:5163/api/User/getUserById/\(userId)") else {
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
                let user = try decoder.decode(UserModel.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func loginUser(phoneNumber: String, password: String, completion: @escaping (Result<Int, Error>) -> Void) {
        // API URL'si
        guard let url = URL(string: "http://localhost:5163/api/User/login") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])))
            return
        }

        // Parametreleri JSON formatında oluşturuyoruz
        let parameters: [String: Any] = [
            "PhoneNumber": phoneNumber,
            "Password": password
        ]
        
        do {
            let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // URLSession ile veri gönderiyoruz
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
                    // JSON cevabını decode ediyoruz
                    let decoder = JSONDecoder()
                    
                    // 'LoginResponse' modeline decode ediyoruz
                    if let loginResponse = try? decoder.decode(LoginResponse.self, from: data) {
                        // Başarılıysa userId'yi döndürüyoruz
                        completion(.success(loginResponse.userId))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response format is incorrect"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

}
